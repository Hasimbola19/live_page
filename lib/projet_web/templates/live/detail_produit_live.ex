defmodule ProjetWeb.Live.DetailProduitLive do
  use Phoenix.LiveView

  def mount(params, session, socket) do
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

  def handle_event("inc", _, socket) do
    quantite = socket.assigns.quantite
    prix_unitaire = socket.assigns.prix_unitiare
    quantite = quantite + 1
    prix_total = prix_unitaire * quantite
    PhoenixLiveSession.put_session(socket, "quantite", quantite)
    PhoenixLiveSession.put_session(socket, "prix_unitaire", prix_unitaire)
    PhoenixLiveSession.put_session(socket, "prix_total", prix_total)
    {:noreply, socket}
  end

  def handle_event("dec", _, socket) do
    quantite = socket.assigns.quantite
    prix_unitaire = socket.assigns.prix_unitiare
    if quantite > 0 do
      quantite = quantite - 1
      prix_total = prix_unitaire * quantite
      PhoenixLiveSession.put_session(socket, "quantite", quantite)
      PhoenixLiveSession.put_session(socket, "prix_unitaire", prix_unitaire)
      PhoenixLiveSession.put_session(socket, "prix_total", prix_total)
      {:noreply, socket}
    else
      {:noreply, socket}
    end
  end

  defp put_session_assigns(socket, session) do
    socket
    |> assign(
      shopping_cart: Map.get(session, "shopping_cart", []),
      quantite: Map.get(session, "quantite", 0),
      prix_unitaire: Map.get(session, "prix_unitaire", 1),
      prix_total: Map.get(session, "prix_total", 0)
    )
  end

  def render(assigns) do
    ProjetWeb.PageView.render("detail_produit.html", assigns)
  end
end
