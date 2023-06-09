defmodule StreamChatWeb.ChatLive.Messages do
  use StreamChatWeb, :html
  import StreamChatWeb.CoreComponents
  require Logger
  def list_messages(assigns) do
    ~H"""
    <div
      id="messages"
      phx-update="stream"
      class="overflow-scroll"
      style="height: calc(84vh); padding: 0 15% 0 15%; overflow-x: hidden;"
      phx-hook="ScrollDown"
      data-scrolled-to-top={@scrolled_to_top}
    >
      <div id="infinite-scroll-marker" phx-hook="InfiniteScroll"></div>
      <div style = {"padding:1rem;#{if @sender_id === message.sender.id, do: "display:flex; justify-content:flex-end; width:100%;"}"}
        :for={{dom_id, message} <- @messages}
        id={dom_id}
        class="mt-2 messages"
        phx-hook="Hover"
        data-toggle={JS.toggle(to: "#message-#{message.id}-buttons")}
      >
        <div style = {"min-width:50%; max-width: 80%"}>
          <.message_details message={message} sender_id={@sender_id}/>
        </div>
      </div>
    </div>
    """
  end

  def message_details(assigns) do
    ~H"""
    <.message_meta message={@message} sender_id={@sender_id} />
    <.message_content message={@message} sender_id={@sender_id} />
    """
  end

  def message_meta(assigns) do
    ~H"""
    <dl style = {"background-color:#282828; padding:1rem; border-radius:2rem 2rem 0 0;#{if @sender_id === @message.sender.id, do: "background-color:#0D7377; display:flex; justify-content:flex-start; width:100%;"}"} class="-my-4 divide-y divide-zinc-100">
      <div class="flex gap-4 sm:gap-2" >
      <%= if @sender_id === @message.sender.id do %>
      <dt class="w-1/8 flex-none text-[0.9rem] leading-8 text-zinc-500" style="font-weight: 900;">
      <p style = "color:#323232;">You</p>
      </dt>
      <.delete_icon id={"message-#{@message.id}-buttons"} phx_click="delete_message" value={@message.id} />
      <% else %>

      <dt class="w-1/8 flex-none text-[0.9rem] leading-8 text-zinc-500" style="font-weight: 900">
      <p style = "color:#0D7377;"><%= @message.sender.username %></p>
      </dt>
      <% end %>

      </div>
      </dl>
        <%= if @message.attachment do %>
        <div  style = {"background-color:#282828; width:100%;#{if @sender_id === @message.sender.id , do: "background-color:#0D7377; direction:rtl;"}"}>

          <img alt="" width="200" height="200" src={~s"#{@message.attachment}"}>

        </div>
        <% end %>
    """
  end

  def message_content(assigns) do
    ~H"""
    <dl style = {" background-color:#282828;border-radius:0 0 2rem 2rem; #{if @sender_id === @message.sender.id, do: "background-color:#0D7377; display:flex; justify-content:flex-end; width:100%;"}"} class="-my-4 divide-y divide-zinc-100">
      <div class="flex gap-4 py-4 sm:gap-2" style = "display:flex; flex-direction:column; width:100%">

        <dd class="text-sm leading-10 text-zinc-700" style = "padding : 0 2rem 0 2rem;">

        <%= if @message.content =~ ~r{^https?://} do %>
          <p>
          <a target="_blank" style = {"color:lightblue; font-size:15pt; #{if @sender_id === @message.sender.id, do: "direction:rtl;"}"} href = {@message.content}><%= @message.content %> </a>
          </p>
        <% else %>
          <p style = {"color:white; font-size:15pt; #{if @sender_id === @message.sender.id, do: "direction:rtl;"}"}><%= @message.content %></p>
        <% end %>
          </dd>
          <span style={"font-weight: 300; font-size:10pt; color:white;direction:rtl; padding : 0 2rem 0 2rem; #{if @sender_id === @message.sender.id, do: "direction:ltr;"}"}><%= String.slice(Kernel.inspect(@message.inserted_at), 15..String.length(Kernel.inspect(@message.inserted_at))-5) %></span>
      </div>
    </dl>
    """
  end
end
