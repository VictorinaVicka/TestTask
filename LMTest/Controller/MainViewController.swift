//
//  MainViewController.swift
//  LMTest
//
//  Created by Виктория Воробьева on 16.04.2021.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    typealias DataSource = UICollectionViewDiffableDataSource<MSection, MChat>
    typealias Snapshot = NSDiffableDataSourceSnapshot<MSection, MChat>
    
    private var sections = Bundle.main.decode([MSection].self, from: "test.json")
    private var provider: Bundle
    
    private lazy var dataSource = makeDataSource()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createComposLayout())
        collectionView.backgroundColor = UIColor.white
        collectionView.register(cellWithClass: ActiveChatCell.self)
        collectionView.register(cellWithClass: ActiveCatalogCell.self)
        collectionView.register(viewWithClass: ActiveHeader.self, kind: "header")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()

    //MARK: - init
    init(provider: Bundle) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        reloadeData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.sizeToFit()
    }
    
    //MARK: - setup
    private func setup() {
        addNavigationBar()
        addSearchController()
        layoutCollectionView()
    }
    
    private func layoutCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func addNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "Поиск товаров"

        let scroll = UINavigationBarAppearance()
        scroll.backgroundColor = .systemGreen
        scroll.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.scrollEdgeAppearance = scroll
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    private func addSearchController() {
        let searsh = UISearchController(searchResultsController: nil)
        searsh.searchBar.placeholder = "Поиск"
        searsh.searchBar.searchTextField.backgroundColor = .white
        searsh.searchBar.searchTextField.layer.cornerRadius = 4
        
        
        searsh.searchBar.setImage(UIImage(), for: .search, state: .normal)
        searsh.searchBar.showsBookmarkButton = true
        searsh.searchBar.setImage(UIImage(systemName: "magnifyingglass"), for: .bookmark, state: .normal)
        navigationItem.searchController = searsh
        
        searsh.searchBar.showsCancelButton = true
        if let smallButton = searsh.searchBar.value(forKey: "cancelButton") as? UIButton {
            smallButton.setImage(UIImage(systemName: "barcode"), for: .normal)
            smallButton.setTitle("", for: .normal)
            smallButton.backgroundColor = .white
            smallButton.tintColor = .gray
            smallButton.layer.cornerRadius = 2
            
        }
    }
    
    // MARK: - DataSource
    
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, chat) -> UICollectionViewCell? in
                
                guard let section = SectionHeaderName(rawValue: indexPath.section) else { fatalError("This section does not exist") }
                
                switch section {
                case .catalog:
                    let cell = collectionView.dequeue(ActiveCatalogCell.self, for: indexPath)
                    cell.configure(with: chat)
                    
                    return cell
                default:
                    let cell = collectionView.dequeue(ActiveChatCell.self, for: indexPath)
                    cell.configure(with: chat)
                    
                    return cell
                }
            })
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            let headerView = collectionView.dequeue(ActiveHeader.self, kind: "header", for: indexPath)
            headerView.headerName.text = self.sections[indexPath.section].headerName
            return headerView
        }
        return dataSource
    }
    
    func reloadeData() {
        var snapshot = NSDiffableDataSourceSnapshot<MSection, MChat>()
        snapshot.appendSections(sections)
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource.apply(snapshot)
    }
    
    // MARK: - CollectionViewLayout
    
    func createComposLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let layoutSection = SectionHeaderName(rawValue: sectionIndex) else { fatalError("This section does not exist") }
            switch layoutSection {
            case .catalog:
                return self.createСatalogSections()
            case .limited:
                return self.createLimitedSections()
            case .bestPrice:
                return self.createBestSections()
            }
        }
        return layout
    }
    
    func createСatalogSections() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 32, leading: 16, bottom: 32, trailing: 32)
        section.interGroupSpacing = 16
        
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), elementKind: "header", alignment: .top)]
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    func createLimitedSections() -> NSCollectionLayoutSection  {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.35), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 50, trailing: 20)
        section.interGroupSpacing = 16
        
        let sectionHeader = createHeaderSections()
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    func createBestSections() -> NSCollectionLayoutSection  {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.35), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 32, leading: 8, bottom: 32, trailing: 8)
        section.interGroupSpacing = 16
        
        let sectionHeader = createHeaderSections()
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func createHeaderSections() -> NSCollectionLayoutBoundarySupplementaryItem  {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                        elementKind: "header",
                                                                        alignment: .top)
        return sectionHeader
    }
    
}
