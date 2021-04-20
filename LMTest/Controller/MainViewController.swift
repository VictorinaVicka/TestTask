//
//  MainViewController.swift
//  LMTest
//
//  Created by Виктория Воробьева on 16.04.2021.
//

import UIKit

class MainViewController: UIViewController {
    
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
        collectionView.register(cellWithClass: ActiveFirstNumberCatalogCell.self)
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
        view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        navigationItem.title = "Поиск товаров"
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
    
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, chat) -> UICollectionViewCell? in
            switch self.sections[indexPath.section].type {
            case "catalog":
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
            
            return headerView
        }
//        dataSource.supplementaryViewProvider = {
//            collectionView, kind, indexPath in
//            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ActiveHeader.reuseId, for: indexPath) as? ActiveHeader else { return nil }
//            guard let firstChat = self.dataSource.itemIdentifier(for: indexPath) else {return nil}
//            guard let section = self.dataSource.snapshot().sectionIdentifier(containingItem: firstChat) else { return nil }
//            if section.headerName.isEmpty { return nil }
//            sectionHeader.headerName.text = section.headerName
//            return sectionHeader
//        }
        
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
    
    func createComposLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = self.sections[sectionIndex]

            switch section.type {
            case "catalog":
                return self.createСatalogSections()
            case "limited":
                return self.createLimitedSections()
            default:
                return self.createBestSections()
            }
        }
        return layout
    }
    
    func createHeaderSections() -> NSCollectionLayoutBoundarySupplementaryItem  {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                        elementKind: "header",
                                                                        alignment: .top)
        return sectionHeader
    }
    
    func createСatalogSections() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = .init(top: 32, leading: 16, bottom: 32, trailing: 32)
        section.interGroupSpacing = 16
        
//        let sectionHeader = createHeaderSections()
//        section.boundarySupplementaryItems = [sectionHeader]
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
        section.contentInsets = .init(top: 32, leading: .zero, bottom: 32, trailing: 32)
        section.interGroupSpacing = 16
        
        let sectionHeader = createHeaderSections()
        section.boundarySupplementaryItems = [sectionHeader]
//        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), elementKind: "header", alignment: .top)]
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    func createBestSections() -> NSCollectionLayoutSection  {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.35), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 32, leading: .zero, bottom: 32, trailing: 32)
        section.interGroupSpacing = 16
        
        let sectionHeader = createHeaderSections()
        section.boundarySupplementaryItems = [sectionHeader]
//        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), elementKind: "header", alignment: .top)]
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func addNavigationBar() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        extendedLayoutIncludesOpaqueBars = true
        navigationItem.hidesSearchBarWhenScrolling = false
        let scroll = UINavigationBarAppearance()
        scroll.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        scroll.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        navigationController?.navigationBar.scrollEdgeAppearance = scroll
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    private func addSearchController() {
        let searsh = UISearchController(searchResultsController: nil)
        searsh.obscuresBackgroundDuringPresentation = false
        searsh.searchBar.placeholder = "Поиск"
        searsh.searchBar.searchTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        searsh.searchBar.searchTextField.borderStyle = .none
        searsh.searchBar.searchTextField.layer.cornerRadius = 4
        searsh.searchBar.searchTextField.leftView = nil
        navigationItem.searchController = searsh
        
        searsh.searchBar.showsCancelButton = true
        if let cancelButton = searsh.searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setImage(UIImage(systemName: "barcode.viewfinder"), for: .normal)
            cancelButton.setTitle("", for: .normal)
            cancelButton.backgroundColor = .white
            cancelButton.tintColor = .gray
        }
    }
}

//extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return sections.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return sections[section].items.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActiveChatCell.reuseId, for: indexPath) as! ActiveChatCell
//        let section = sections[indexPath.section]
//        let item = section.items[indexPath.item]
//        cell.configure(with: item)
//        return cell
//    }
//}

