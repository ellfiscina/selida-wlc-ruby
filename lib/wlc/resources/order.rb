module Wlc
  module Resources
    class Order < Resource
      ENDPOINTS = { create: '/Pedidos/Pedido/EnviaPedidos',
                    find: '/Pedidos/Pedido/ConsultaStatusPedido' }

      def create(resource)
        client.post(ENDPOINTS[:create], resource)
      end

      def find(codigo)
        client.get(ENDPOINTS[:find], { codigo: codigo })
      end
    end
  end
end
