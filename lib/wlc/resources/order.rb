module Wlc
  module Resources
    class Order < Resource
      ENDPOINTS = { create: '/Pedidos/Pedido/EnviaPedidos',
                    find: '/Pedidos/Pedido/ConsultaStatusPedido' }

      def create(resource)
        client.post(ENDPOINTS[:create], resource)
      end

      def find(codigo)
        response = client.get(ENDPOINTS[:find], { NumeroPedido: codigo })
        response['success'] ? response['obj_return'] : response
      end
    end
  end
end
