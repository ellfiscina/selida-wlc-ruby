module Wlc
  module Resources
    class Product < Resource
      ENDPOINTS = { index: '/Produtos/Produto/ConsultaProdutos',
                    availability: '/Produtos/Produto/ConsultaDisponibilidadeProduto' }

      def all
        response = client.get(ENDPOINTS[:index])
        response.success ? response.products : response
      end

      def find(codigo)
        client.get(ENDPOINTS[:index], { codigo: codigo })
      end

      def available?(codigo)
        resp = client.get(ENDPOINTS[:availability], { codigo: codigo })
        resp.availability
      end
    end
  end
end
