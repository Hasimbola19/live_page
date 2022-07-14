defmodule ProjetWeb.Live.ProduitLive do
  use Phoenix.LiveView
  use ProjetWeb, :live_view

  def mount(_params, session, socket) do
    socket =
      socket
      |> PhoenixLiveSession.maybe_subscribe(session)
      |> put_session_assigns(session)

    IO.inspect session
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
    quantite = quantite + 1
    PhoenixLiveSession.put_session(socket, "quantite", quantite)
    {:noreply, socket}
  end

  def handle_event("dec", _, socket) do
    quantite = socket.assigns.quantite
    if quantite > 0 do
      quantite = quantite - 1
      PhoenixLiveSession.put_session(socket, "quantite", quantite)
      {:noreply, socket}
    else
      {:noreply, socket}
    end
  end

  defp put_session_assigns(socket, session) do
    socket
    |> assign(
      shopping_cart: Map.get(session, "shopping_cart", []),
      quantite: Map.get(session, "quantite", 0)
    )
  end

  def render(assigns) do
    ProjetWeb.PageView.render("produit.html", assigns)
  end
end
