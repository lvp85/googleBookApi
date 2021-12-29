//
//  ViewController.swift
//  googleBookApi
//
//  Created by Udagedara Dehigama on 2021/12/29.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var TableView: UITableView!
    
    var dataList = [Items]()
    var filetreData = [Items]()
    var isFiltered  = false
    override func viewDidLoad() {
      
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TableView.register(UINib(nibName: "GoogleBookTableViewCell", bundle: nil), forCellReuseIdentifier: "GoogleBookCell")
        loadingData()
    }
    func loadingData(){
        let candidateUrl = "https://www.googleapis.com/books/v1/volumes?q=flowers&startIndex=0&maxResults=10"
        if let url = URL(string: candidateUrl){
            URLSession.shared.dataTask(with:URLRequest(url: url)){(data,response,error) in
                do{
                    let item = try JSONDecoder().decode(GoogleApiBook.self, from: data!)
                    DispatchQueue.main.async {
                       // check this
                        self.dataList = item.items
                       // print(self.dataList)
                       self.TableView.reloadData()
                    }
                }
                catch{
                    print(error)
                }
            }.resume()
        }
    }
    
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text  = textField.text{
            filterText(text+string)
            
            }
            return true
    }
    func filterText(_ query:String){
        filetreData.removeAll()
        for data in dataList{

            if data.volumeInfo.title.lowercased().starts(with: query.lowercased()){
                filetreData.append(data)
            }
        }
        TableView.reloadData()
       
        isFiltered = true
       
    }

}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filetreData.isEmpty{
            return filetreData.count
        }
        return isFiltered ? 0 : dataList.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoogleBookCell", for: indexPath) as! GoogleBookTableViewCell
        
        
        //----- change part
        
        if !filetreData.isEmpty{
           
            cell.OnBind(data:filetreData[indexPath.row])
           
        }
        else
        {
            cell.OnBind(data:dataList[indexPath.row])
        }
        
        
     
        return cell
    }
    
    
}
