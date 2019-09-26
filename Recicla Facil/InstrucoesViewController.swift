//
//  InstrucoesViewController.swift
//  Recicla Facil
//
//  Created by aluno on 23/09/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class InstrucoesViewController: UIViewController,UIScrollViewDelegate {
    var slides:[Slide] = [];
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBAction func ChamarSkip(_ sender: Any) {
        print("Apertou no botao")
    }
    
    @IBOutlet weak var btnProsseguir: UIButton!
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnProsseguir.isHidden = true
        
        scrollView.addSubview(contentView)
        
        scrollView.delegate = self
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
      
    }
    
    
    func createSlides() -> [Slide] {
        
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageView.image = UIImage(named: "delivery")
        slide1.labelTitulo.text = "Separe seu lixo"
        slide1.labelOutroTexto.text = "Separe seu lixo reciclável para realizar um descarte futuro"
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageView.image = UIImage(named: "destination1")
        slide2.labelTitulo.text = "Saiba onde encontrar"
        slide2.labelOutroTexto.text = "Localize um ponto no mapa para realizar o seu descarte"
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageView.image = UIImage(named: "winners")
        slide3.labelTitulo.text = "Receba recompensas"
        slide3.labelOutroTexto.text = "Acumule pontos com as entidades parceiras"
        
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.imageView.image = UIImage(named: "points")
        slide4.labelTitulo.text = "Recompensas"
        slide4.labelOutroTexto.text = "Utilize seus pontos para obter recompensas em lojas parceiras dos ecopontos"
        
        
        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.imageView.image = UIImage(named: "celebration2")
        slide5.labelTitulo.text = "Gratificação"
        slide5.labelOutroTexto.text = "Tenha a satisfação de estar contribuindo para um mundo melhor"
        
        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        
//        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: scrollView.frame.height)
//        scrollView.isPagingEnabled = true
//
//        for i in 0 ..< slides.count {
//            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: scrollView.frame.height)
//            scrollView.addSubview(slides[i])
//        }
//
//
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor)
        ])
        
        scrollView.isPagingEnabled = true
        
        var lastSlide: Slide?
        for i in 0..<slides.count {
            
            let currentSlide = slides[i]
            contentView.addSubview(currentSlide)
            currentSlide.translatesAutoresizingMaskIntoConstraints = false
            
            if let lastSlide = lastSlide {
                currentSlide.leftAnchor.constraint(equalTo: lastSlide.rightAnchor).isActive = true
            } else {
                currentSlide.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
            }

            currentSlide.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true

            currentSlide.bottomAnchor.constraint(equalTo: pageControl.topAnchor).isActive = true
            currentSlide.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
            
            if i == slides.count - 1 {
                currentSlide.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
               
            }
            //currentSlide.backgroundColor = UIColor.red
            lastSlide = currentSlide
            
          
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        
        /*
         * below code changes the background color of view on paging the scrollview
         */
        //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
        
        
        /*
         * below code scales the imageview on paging the scrollview
         */
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        btnProsseguir.isHidden = true
        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
            
            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
            
        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
            slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
            
        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
            slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
            
        } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
            slides[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
            slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
             btnProsseguir.isHidden = false
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
