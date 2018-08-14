# WLC Ruby SDK
> Gem para integrar com a API WLC da selida.com.br

[![Gem Version](https://badge.fury.io/rb/wlc-sdk-ruby.svg)](https://badge.fury.io/rb/wlc-sdk-ruby)

**Índice**

- [Instalação](#instalação)
- [Configurando a autenticação](#configurando-a-autenticação)
- [Exemplos de Uso](#produtos):
  - [Produtos](#produtos)
    - [Listagem](#listagem)
  - [Resgates](#resgates)
    - [Criação](#criação)
    - [Consulta](#consulta)
  - [Tracking do pedido](#tracking-do-pedido)
- [Documentação](#documentação)
- [Licença](#licença)

## Instalação
Adicione a seguinte linha no seu Gemfile:
```ruby
gem 'wlc-sdk-ruby', require: 'wlc'
```
Depois, rode o `bundle install`.

## Configurando a autenticação
Crie o arquivo `wlc.rb` no caminho 'config/initializers' com os dados para autenticação com a sua conta:
```ruby
Wlc.configure do |config|
  config.username = 'usuario@email.com' # Substitua pelo seu username de login
  config.password = 'senhaXXX' # Substitua pelo sua senha de login
end
```

## Produtos
### Listagem
Serviço responsável por identificar os produtos do catálogo, negociado anteriormente junto ao comercial da Selida. Todos os produtos são identificados pelo código.
```ruby
products = Wlc.products.all
```

### Consulta
Serviço responsável por identificar um produto do catálogo.
```ruby
codigo = 138
product = Wlc.products.find(codigo)
```

### Disponibilidade
Serviço responsável por identificar a disponibilidade de um produto.
```ruby
codigo = 138
availability = Wlc.products.available?(codigo)
```

## Resgates
### Criação
Serviço responsável por enviar o resgate do pedido - Cartão físico, virtual, recarga, pague contas e cartão pré-pago.
```ruby
order = Wlc.order.create({
    numero_pedido: 'WLC_001',
    codigo: '138',
    nome: 'teste holder',
    identificacao: '938.653.563-70',
    tipo_identificacao: 'CPF',
    data_nascimento: '2016-08-23',
    email: 'bryan-luiz80@yahoo.es',
    telefone: '(81)3702-8611',
    celular: '(81)98985-8726',
    cep: '54340-447',
    endereco: '2ª Travessa José',
    numero: '660',
    complemento: 'Apartamento 22',
    bairro: 'Prazeres',
    quantidade: '1',
    peso: '2.5',
    valor_unitario: '384.29',
    valor_frete: '16.90',
    valortotal: '401.29'
})
```

### Consulta
Serviço responsável por identificar cada pedido individualmente.
```ruby
numero_pedido = 'WLC_001' # Controle do cliente
order = Wlc.order.find(numero_pedido)
```

## Documentação
[Documentação oficial](http://documentacao.selida.com.br)

## Licença
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
