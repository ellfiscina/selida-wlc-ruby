module Wlc
  module Resources
    class Product < Resource
      ENDPOINTS = { index: '/Produtos/Produto/ConsultaProdutos',
                    find: '/Produtos/Produto/ConsultaProduto',
                    availability: '/Produtos/Produto/ConsultaDisponibilidadeProduto',
                    category: '/Produtos/Produto/ConsultaCategorias' }

      def all
        response = client.get(ENDPOINTS[:index])
        response['success'] ? response['obj_return'] : response
      end

      def find(codigo)
        response = client.get(ENDPOINTS[:find], { Codigo: codigo })
        response['success'] ? response['obj_return'] : response
      end

      def available?(codigo)
        response = client.get(ENDPOINTS[:availability], { Codigo: codigo })
        response['obj_return'][:disponivel]
      end

      def categories
        response = client.get(ENDPOINTS[:category])
        response['success'] ? response['obj_return'] : response
      end
    end
  end
end
