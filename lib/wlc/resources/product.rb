module Wlc
  module Resources
    class Product < Resource
      ENDPOINTS = { index: '/Produtos/Produto/ConsultaProdutos',
                    find: '/Produtos/Produto/ConsultaProduto',
                    availability: '/Produtos/Produto/ConsultaDisponibilidadeProduto' }

      def all
        response = client.get(ENDPOINTS[:index])
        response['success'] ? response['obj_return'] : response
      end

      def find(codigo)
        response = client.get(ENDPOINTS[:find], { Codigo: codigo })
        response['success'] ? response['obj_return'] : response
      end

      def available?(codigo)
        resp = client.get(ENDPOINTS[:availability], { codigo: codigo })
        resp['obj_return'][:disponivel]
      end
    end
  end
end
