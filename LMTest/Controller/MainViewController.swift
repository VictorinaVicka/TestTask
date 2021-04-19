//
//  MainViewController.swift
//  LMTest
//
//  Created by Виктория Воробьева on 16.04.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var sections = Bundle.main.decode([MSection].self, from: "test.json")
    var provider: Bundle
    var dataSourse: UICollectionViewDiffableDataSource<MSection, MChat>?

    init(provider: Bundle) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        navigationItem.title = "Поиск товаров"
        addNavigationBar()
        addSearchController()
        setupCV()
        reloadeData()
        createDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.sizeToFit()
    }

    func setupCV() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createComposLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = #colorLiteral(red: 0.9790343642, green: 0.9791979194, blue: 0.9790129066, alpha: 1)
        view.addSubview(collectionView)
        collectionView.register(ActiveChatCell.self, forCellWithReuseIdentifier: ActiveChatCell.reuseId)
        collectionView.register(ActiveCatalogCell.self, forCellWithReuseIdentifier: ActiveCatalogCell.reuseId)
        collectionView.register(ActiveFirstNumberCatalogCell.self, forCellWithReuseIdentifier: ActiveFirstNumberCatalogCell.reuseId)
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
    }
    
    func createDataSource() {
        dataSourse = UICollectionViewDiffableDataSource<MSection, MChat>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, chat) -> UICollectionViewCell? in
            switch self.sections[indexPath.section].type {
            case "catalog":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActiveCatalogCell.reuseId, for: indexPath) as? ActiveCatalogCell
                cell?.configure(with: chat)
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActiveChatCell.reuseId, for: indexPath) as? ActiveChatCell
                cell?.configure(with: chat)
                return cell
            }
        })
    }
    
    func reloadeData() {
        var snapshot = NSDiffableDataSourceSnapshot<MSection, MChat>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSourse?.apply(snapshot)
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
        section.contentInsets = .init(top: 32, leading: .zero, bottom: 32, trailing: 32)
        section.interGroupSpacing = 16
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), elementKind: "header", alignment: .top)]
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
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), elementKind: "header", alignment: .top)]
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

