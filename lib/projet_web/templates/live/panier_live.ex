defmodule ProjetWeb.Live.PanierLive do
  use Phoenix.LiveView

  def mount(_params, session, socket) do

    socket =
      socket
      |> PhoenixLiveSession.maybe_subscribe(session)
      |> put_session_assigns(session)

    {:ok, socket, layout: {ProjetWeb.LayoutView, "live.html"}}
  end

  def handle_info({:live_session_updated, session}, socket) do
    {:noreply, put_session_assigns(socket, session)}
  end

  def handle_event("add_to_cart", params, socket) do
    updated_cart = [params["product_id"] | socket.assigns.shopping_cart]

    PhoenixLiveSession.put_session(socket, "shopping_cart", updated_cart)

    {:noreply, socket}
  end

  def handle_event("dec", _, socket) do
    quantite = socket.assigns.quantite
    prix_total = socket.assigns.prix_total
    prix_unitaire = socket.assigns.prix_unitaire
    if quantite > 0 do
      quantite = quantite - 1
      prix_total = prix_unitaire * quantite
      PhoenixLiveSession.put_session(socket, "quantite", quantite)
      PhoenixLiveSession.put_session(socket, "prix_total", prix_total)
      PhoenixLiveSession.put_session(socket, "prix_unitiare", prix_unitaire)
      {:noreply, socket}
    else
      {:noreply, socket}
    end
  end

  def handle_event("inc", _, socket) do
    quantite = socket.assigns.quantite
    prix_total = socket.assigns.prix_total
    prix_unitaire = socket.assigns.prix_unitaire
    quantite = quantite + 1
    prix_total = prix_unitaire * quantite
    PhoenixLiveSession.put_session(socket, "quantite", quantite)
    PhoenixLiveSession.put_session(socket, "prix_total", prix_total)
    PhoenixLiveSession.put_session(socket, "prix_unitiare", prix_unitaire)
    {:noreply, socket}
  end

  defp put_session_assigns(socket, session) do
    socket
    |> assign(
      shopping_cart: Map.get(session, "shopping_cart", []),
      quantite: Map.get(session, "quantite", 0),
      prix_unitaire: Map.get(session, "prix_unitaire", 0.5),
      prix_total: Map.get(session, "prix_total", 0)
    )
  end

  def render(assigns) do
    ProjetWeb.PageView.render("panier.html", assigns)
  end
end
