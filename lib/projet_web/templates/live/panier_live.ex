defmodule ProjetWeb.Live.PanierLive do
  use Phoenix.LiveView

  def mount(_params, session, socket) do
    IO.inspect session
    quantite = 0
    prix_total = 0
    prix_unitaire = 0.5
    {:ok,
      socket
        |> assign(quantite: quantite, prix_unitaire: prix_unitaire, prix_total: prix_total),
        layout: {ProjetWeb.LayoutView, "live.html"}
    }
  end

  def render(assigns) do
    ProjetWeb.PageView.render("panier.html", assigns)
  end

  # Moyen pour faire passer en session les quantites, prix_unitaire, prix_total en liveview

  def handle_event("sub", _params, socket) do
    number = socket.assigns.quantite
    prix_unitaire = socket.assigns.prix_unitaire
    if number > 1 do
      number = number - 1
      prix_total = number * prix_unitaire
      {:noreply,
        socket |> assign(quantite: number, prix_total: prix_total, prix_unitaire: prix_unitaire)
      }
    else
      prix_total = number * prix_unitaire
      {:noreply,
        socket |> assign(quantite: number, prix_total: prix_total, prix_unitaire: prix_unitaire)
      }
    end
  end

  def handle_event("add", _params, socket) do
    number = socket.assigns.quantite
    prix_unitaire = socket.assigns.prix_unitaire
    number = number + 1
    prix_total = number * prix_unitaire
    {:noreply,
      socket |> assign(quantite: number, prix_total: prix_total, prix_unitaire: prix_unitaire)
    }
  end
end
