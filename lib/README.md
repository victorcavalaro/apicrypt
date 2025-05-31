# CoinMarketCap Flutter App (MVVM)

Este é um aplicativo Flutter que consome a API da CoinMarketCap para listar criptomoedas, seguindo o padrão arquitetural MVVM.

## Funcionalidades

* Listagem de criptomoedas com informações como sigla, nome e cotação em USD e BRL.
* Busca por múltiplas criptomoedas (separadas por vírgula).
* Atualização de dados via "pull-to-refresh" ou botão de atualizar.
* Exibição de um indicador de progresso durante o carregamento dos dados.
* Uso de valores padrão para criptomoedas se nenhuma busca for especificada.
* Exibição de detalhes adicionais da criptomoeda ao clicar em um item da lista (Name, Symbol, Data Added, Preços).
* Verificação de conexão com a internet (implícita pela falha na API call).

## Arquitetura

O projeto utiliza o padrão **MVVM (Model-View-ViewModel)**:

* **View (`lib/view/`)**: Responsável pela interface do usuário (UI) e interações. Contém as telas (`screens`) e widgets reutilizáveis (`widgets`).
* **ViewModel (`lib/viewmodel/`)**: Contém a lógica de apresentação da UI e gerencia o estado da View. Comunica-se com o Repository para obter dados. Utiliza `ChangeNotifier` com o pacote `provider` para gerenciamento de estado.
* **Repository (`lib/data/repositories/`)**: Abstrai a origem dos dados. Comunica-se com o DataSource para buscar os dados brutos e os transforma em Models.
* **DataSource (`lib/data/datasources/`)**: Responsável pela comunicação direta com a API da CoinMarketCap.
* **Model (`lib/data/models/`)**: Representa a estrutura dos dados das criptomoedas.
* **Core (`lib/core/`)**: Contém utilitários (`utils`), constantes (`constants`) e outros códigos centrais da aplicação.

## Pré-requisitos

* Flutter SDK: [Instruções de Instalação](https://flutter.dev/docs/get-started/install)
* Um editor de código (VS Code, Android Studio, etc.)
* Uma chave de API da [CoinMarketCap](https://coinmarketcap.com/api/)

## Configuração

1.  **Clone o repositório (se aplicável):**
    ```bash
    git clone <url-do-repositorio>
    cd coinmarketcap_app
    ```

2.  **Obtenha uma API Key da CoinMarketCap:**
    * Visite [https://coinmarketcap.com/api/](https://coinmarketcap.com/api/) e crie uma conta ou faça login.
    * Obtenha sua chave de API no dashboard.

3.  **Configure a API Key no projeto:**
    * Abra o arquivo `lib/core/constants/app_constants.dart`.
    * Substitua o valor da constante `apiKey` pela sua chave:
        ```dart
        static const String apiKey = "SUA_API_KEY_AQUI";
        ```
    * **Importante:** Não cometa sua chave de API em repositórios públicos. Considere usar variáveis de ambiente ou um arquivo de configuração ignorado pelo Git para projetos reais.

4.  **Instale as dependências:**
    ```bash
    flutter pub get
    ```

## Execução

1.  **Certifique-se de que um emulador esteja rodando ou um dispositivo físico esteja conectado.**
2.  **Execute o aplicativo:**
    ```bash
    flutter run
    ```

## Estrutura de Pastas Detalhada