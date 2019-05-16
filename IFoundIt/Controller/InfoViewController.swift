//
//  InfoViewController.swift
//  IFoundIt
//
//  Created by AMIMOBILE on 26/03/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit
import SafariServices

class InfoViewController: UIViewController {

    // MARK: - Vars, Lets
    @IBOutlet weak var infoTextView: CustomTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInfoText()
    }
    
    // MARK: -  Methods
    
    // Set up text for infomation
    private func setupInfoText() {
        infoTextView.text = "Vous avez trouvé un objet: \nSur la voie publique:  Déposez-le dans un commissariat.\nSur le réseau RATP: Adressez-vous auprès des agents du réseau.\nDans un aéroport :  Déposez-le auprès du service compétent de l’aéroport.\nDans un établissement parisien recevant du public (Tour Eiffel, grands magasins, musées, foires et expositions, etc.): Confiez-le au service approprié.\nDans tous les cas, on vous proposera de laisser vos coordonnées pour vous permettre de bénéficier des droits de l’inventeur.....\n\nDroit de l'inventeur:\nL'Inventeur est la personne qui a trouvé l'object.\nLes délais de conservation des objets varient suivant les valeurs des objects.\n\nTout objet d’une valeur estimée inférieure à 100 €: à la disposition de l'inventeur entre le 3e et le 4e mois suivant le jour de découverte de l'objet.\nTout objet d’une valeur estimée supérieure ou égale à 100 € : à la disposition de l’inventeur entre le 12e et le 18e mois suivant le jour de découverte de l'objet."
    }
    
    @IBAction func declareButton() {
        let InscriptionView = self.storyboard?.instantiateViewController(withIdentifier: "InscriptionViewController") as! InscriptionViewController
        self.navigationController?.pushViewController(InscriptionView, animated: true)
    }
    
    // Navigating to other site
    @IBAction func getDirectionSafari() {
        directionSafari()
    }
    
    private func directionSafari() {
        let siteUrl = "https://www.prefecturedepolice.interieur.gouv.fr/Demarches/Particulier/Autres-demarches/Le-service-des-objets-trouves#ancre-2"
        guard let url = URL(string: siteUrl) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }

}
