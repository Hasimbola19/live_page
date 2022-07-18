defmodule ProjetWeb.Live.IndexLive do
  use Phoenix.LiveView

  def mount(_params, session, socket) do
    if connected?(socket), do: self() |> IO.inspect(label: "pid")
    IO.inspect socket.transport_pid
    IO.inspect socket.view
    IO.inspect socket.redirected
    IO.inspect socket.private
    socket =
      socket
      |> PhoenixLiveSession.maybe_subscribe(session)
      |> put_session_assigns(session)

    {:ok, socket, layout: {ProjetWeb.LayoutView, "live.html"}}
  end

  def preload(list_of_assigns) do
    list_of_assigns
    |> IO.inspect(label: "PRELOAD")
  end

  def handle_info({:live_session_updated, session}, socket) do
    {:noreply, put_session_assigns(socket, session)}
  end

  defp put_session_assigns(socket, session) do
    socket
    |> assign(
      quantite: Map.get(session, "quantite", 0),
      prix_unitaire: Map.get(session, "prix_unitaire", 0.5),
      prix_total: Map.get(session, "prix_total", 0)
    )
  end

  def render(assigns) do
    ProjetWeb.PageView.render("index.html", assigns)
  end
end
