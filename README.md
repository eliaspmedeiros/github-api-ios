A relação entre os componentes de um módulo **VIPER** é bem simples, e é definida no arquivo com sufixo `Protocols`:

```
import Foundation

// presenter -> router
// world -> router
protocol RepositoryListRouterInterface {
    func navigateToRepositoryDetail(repoId: Int)
}

// presenter -> view
protocol RepositoryListViewInterface: AnyObject {
    func reload()
    func showActivityIndicator()
    func hideActivityIndicator()
    func displayError(message: String)
}

// view -> presenter
protocol RepositoryListModuleInterface {
    func moduleDidLoad()
    func refreshAction()
    func itemSelected(atRow: Int)
}

// presenter -> interactor
protocol RepositoryListInteractorInput {
    func fetchData(forPage: Int)
}

// interactor -> presenter
protocol RepositoryListInteractorOutput: AnyObject {
    func dataFetched(_: RepositoryListModel, forPage: Int)
    func fetchRequestIgnored(onPage: Int)
    func error(message: String)
}
```

Todos os protocolos denotam interação do **Presenter** com algum outro objeto, seja recebendo eventos ou emitindo instruções.

Mesmo sem as implementações, olhando apenas para os protocolos, é visível que existe uma reação a evento na **View**, na qual o **Presenter** é acionado: o método `func itemSelected(atRow: Int)`.

Este método está implementado de maneira bem simples no **Presenter**:
```
  func itemSelected(atRow row: Int) {
      if let repository = repositories[safe: row] {
          router?.navigateToRepositoryDetail(repoId: repository.id)
      }
  }

```

A implementação do **Router** preocupa-se apenas com a execução da navegação, recebendo por parâmetro qualquer dado que seja necessário:
```
import UIKit

class RepositoryListRouter {
    weak var navigationController: UINavigationController?
}

extension RepositoryListRouter: RepositoryListRouterInterface {
    func navigateToRepositoryDetail(repoId: Int) {
        if let navigation = navigationController {
            let viewController = RepositoryDetailRouter.createModule(using: navigation, andRepoId: repoId)
            navigation.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: builder
extension RepositoryListRouter {
    class func createModule(using navigationController: UINavigationController) -> UIViewController {
        let router = RepositoryListRouter()
        let presenter = RepositoryListPresenter()
        let view = RepositoryListViewController()
        let interactor = RepositoryListInteractor()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        view.presenter = presenter
        interactor.output = presenter
        router.navigationController = navigationController
        
        return view
    }
}
```

Aqui também temos uma função de classe para criação do *módulo*, fazendo as inicializações e associações necessárias. O **Router** da lista conversa com um outro **Router**, o de detalhes.

Este, por enquanto, só tem a responsabilidade de instanciar os objetos que compõe o módulo:
```
import UIKit

class RepositoryDetailRouter {
    weak var navigationController: UINavigationController?
}

extension RepositoryDetailRouter: RepositoryDetailRouterInterface {
}

// MARK: builder
extension RepositoryDetailRouter {
    class func createModule(using navigationController: UINavigationController, andRepoId repoId: Int) -> UIViewController {
        let router = RepositoryDetailRouter()
        let presenter = RepositoryDetailPresenter(repoId: repoId)
        let view = RepositoryDetailViewController()
        let interactor = RepositoryDetailInteractor()

        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        view.presenter = presenter
        interactor.output = presenter
        router.navigationController = navigationController

        return view
    }
}
```

Uma ação de voltar ou mesmo uma navegação para uma terceira tela poderia ser definita no protocolo `RepositoryDetailRouterInterface` e implementada na extension correspondente dentro deste **Router**.