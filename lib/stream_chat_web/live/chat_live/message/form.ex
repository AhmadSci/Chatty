defmodule StreamChatWeb.ChatLive.Message.Form do
  use StreamChatWeb, :live_component
  require Logger
  import StreamChatWeb.CoreComponents
  alias StreamChat.Chat
  alias StreamChat.Chat.Message

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_changeset
     |> allow_upload(:attachment, accept: ~w(.jpg .jpeg .png .rar), max_entries: 1)}
  end

  def assign_changeset(socket) do
    assign(socket, :changeset, Chat.change_message(%Message{}))
  end

  def render(assigns) do
    ~H"""
    <div>
      <.simple_form
        :let={f}
        for={@changeset}
        phx-submit="save"
        phx-change="update"
        phx-target={@myself}
      >
        <.input
          autocomplete="off"
          phx-keydown={show_modal("edit_message")}
          phx-key="ArrowUp"
          phx-focus="unpin_scrollbar_from_top"
          field={{f, :content}}
          style = "background-color:transparent; border: 1px solid #0D7377; color :white"
        />

        <div phx-drop-target="{@uploads.attachment.ref}" style = "color:white; display:flex">
          <.live_file_input upload={@uploads.attachment} />
          <div style = "max-width:100px; display:flex; column-gap:1rem">
            <%= for entry <- @uploads.attachment.entries do %>
              <.live_img_preview entry={entry} />
            <% end %>
          </div>
        </div>
        <:actions>
          <.button>send</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def handle_event("update", %{"message" => %{"content" => content}}, socket) do
    {:noreply, socket |> assign(:changeset, Chat.change_message(%Message{content: content}))}
  end

  def handle_event("save", %{"message" => %{"content" => content}}, socket) do
    file_path =
      consume_uploaded_entries(socket, :attachment, fn %{path: path}, _entry ->
        dest = Path.join("priv/static/uploads", Path.basename(path))
        File.cp!(path, dest)
        {:ok, ~p"/uploads/#{Path.basename(dest)}"}
      end)
      Logger.info(String.slice(Kernel.inspect(file_path), 2..String.length(Kernel.inspect(file_path))-3))

    Chat.create_message(%{
      content: content,
      room_id: socket.assigns.room_id,
      sender_id: socket.assigns.sender_id,
      attachment: String.slice(Kernel.inspect(file_path), 2..String.length(Kernel.inspect(file_path))-3)
    })
    {:noreply, assign_changeset(socket)}
  end
end
