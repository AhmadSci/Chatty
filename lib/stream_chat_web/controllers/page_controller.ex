defmodule StreamChatWeb.PageController do
  use StreamChatWeb, :controller

  def home(conn, _params) do
    #if the user is logged in, redirect to the login page
    if !conn.assigns.current_user do
      conn
      |> put_flash(:error, "You need to log in first.")
      |> redirect(to: ~p"/users/log_in")
    else
      # redrect to the chat page
      conn
      |> put_flash(:info, "Welcome to Chatty!")
      |> redirect(to: ~p"/rooms")
    end
  end
end
