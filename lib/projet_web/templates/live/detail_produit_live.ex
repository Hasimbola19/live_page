defmodule ProjetWeb.Live.DetailProduitLive do
  use Phoenix.LiveView

  def mount(params, _session, socket) do
    IO.inspect params
    quantite = 0
    prix_unitaire = 0.5
    prix_total = 0
    {:ok,
      socket |> assign(quantite: quantite, prix_total: prix_total, prix_unitaire: prix_unitaire) ,layout: {ProjetWeb.LayoutView, "live.html"}
    }
  end

  def handle_event("sub", _params, socket) do
    number = socket.assigns.quantite
    prix_unitaire = socket.assigns.prix_unitaire
    if number > 1 do
      number = number - 1
      prix_total = number * prix_unitaire
      IO.inspect prix_total
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
    IO.inspect prix_total
    {:noreply,
      socket |> assign(quantite: number, prix_total: prix_total, prix_unitaire: prix_unitaire)
    }
  end

  def render(assigns) do
    ProjetWeb.PageView.render("detail_produit.html", assigns)
  end
end
