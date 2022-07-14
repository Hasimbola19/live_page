defmodule ProjetWeb.Live.ProduitLive do
  use Phoenix.LiveView
  use ProjetWeb, :live_view

  def mount(_params, session, socket) do
    socket = socket
    |> PhoenixLiveSession.maybe_subscribe(session)
    |> put_session_assigns(session)
    {:ok,
      socket ,layout: {ProjetWeb.LayoutView, "live.html"}
    }
  end

  def handle_info({:live_session_updated, session}, socket) do
    {:noreply, put_session_assigns(socket, session)}
  end

  def handle_event("add", %{"quantite" => quantite}, socket) do
    panier = [quantite | socket.assigns.quantite]
    PhoenixLiveSession.put_session(socket, "cart", panier)

    {:noreply, socket |> assign(panier: panier)}
  end

  def put_session_assigns(socket, session) do
    socket
    |> assign(:cart, Map.get(session, "cart", []))
  end

  def render(assigns) do
    ProjetWeb.PageView.render("produit.html", assigns)
  end
end
