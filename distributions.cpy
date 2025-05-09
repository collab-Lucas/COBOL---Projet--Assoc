       Ajout_distributions.
           OPEN I-O fdistributions
           DISPLAY "Création d'une nouvelle distribution"

           MOVE 0 TO Wtrouver
           DISPLAY "Entrez l'ID de la distribution : "
           ACCEPT WidD
           DISPLAY "Entrez l'ID du groupe : "
           ACCEPT WidGroupe
           DISPLAY "Entrez l'ID du centre : "
           ACCEPT WidC
           DISPLAY "Entrez la date : "
           ACCEPT Wdate
           DISPLAY "Entrez l'horaire : "
           ACCEPT Whoraire
           DISPLAY "Entrez le produit : "
           ACCEPT Wproduit
           DISPLAY "Entrez la quantité : "
           ACCEPT Wquantite

           MOVE WidD TO fdi_id
           MOVE WidGroupe TO fdi_idGroupe
           MOVE Wdate TO fdi_date
           MOVE WidC TO fdi_centre
           MOVE Whoraire TO fdi_horaire
           MOVE Wproduit TO fdi_produit
           MOVE Wquantite TO fdi_quantite

           WRITE tamp_fdistributions
           END-WRITE
           CLOSE fdistributions.

       Affichage_distributions.
           OPEN INPUT fdistributions
           MOVE 0 TO Wfin
           PERFORM WITH TEST AFTER UNTIL Wfin = 1
           READ fdistributions NEXT
           AT END MOVE 1 TO Wfin
           NOT AT END
               DISPLAY "numéro de distribution:" fdi_id
               DISPLAY "groupe :" fdi_idGroupe
               DISPLAY "date :" fdi_date
               DISPLAY "horaire :" fdi_horaire
               DISPLAY "produit :" fdi_produit
               DISPLAY "quantite:" fdi_quantite
           END-READ
           END-PERFORM
           CLOSE fdistributions.
           
       Affichage_dis_bene.
           OPEN INPUT fdistributions
           MOVE 0 TO Wfin 
           MOVE WidGroupeUtili TO fdi_idGroupe
           START fdistributions KEY IS fdi_idGroupe 
           PERFORM WITH TEST AFTER UNTIL Wfin = 1
               READ NEXT fdistributions
                   AT END 
                       MOVE 1 TO Wfin
                   NOT AT END
                       IF fdi_idGroupe = WidGroupeUtili THEN
                           DISPLAY "numéro de distribution:" fdi_id
                           DISPLAY "groupe :" fdi_idGroupe
                           DISPLAY "date :" fdi_date
                           DISPLAY "centre :" fdi_centre
                           DISPLAY "horaire :" fdi_horaire
                           DISPLAY "produit :" fdi_produit
                           DISPLAY "quantite:" fdi_quantite
                       ELSE
                           MOVE 1 TO Wfin
                       END-IF
               END-READ
           END-PERFORM
           CLOSE fdistributions.

       Affichage_distributions_groupes.
           OPEN INPUT fdistributions
           MOVE 0 TO Wtrouve

           PERFORM WITH TEST AFTER UNTIL Wtrouve = 0 AND WidGroupe <> 0
                   DISPLAY  "Entrez l ID du groupe(1 Si pas de groupe):"
                   ACCEPT WidGroupe
                
                   MOVE 0 TO Wtrouve

                   OPEN INPUT fgroupes
                   MOVE WidGroupe TO fgr_id
                   READ fgroupes
                      INVALID KEY 
                      DISPLAY "groupe non trouver"
                      NOT INVALID KEY
                           MOVE 1 TO Wtrouve
                           DISPLAY "groupe trouver"
                  END-READ 
           END-PERFORM

           MOVE 0 TO Wfin
           MOVE WidGroupe TO fdi_idGroupe
           PERFORM WITH TEST AFTER UNTIL Wfin = 1
             READ fdistributions KEY IS fdi_idGroupe  NEXT
               AT END MOVE 1 TO Wfin
               NOT AT END
                   DISPLAY "numéro de distribution:" fdi_id
                       DISPLAY "groupe :" fdi_idGroupe
                       DISPLAY "date :" fdi_date
                       DISPLAY "horaire :" fdi_horaire
                       DISPLAY "centre :" fdi_centre
                       DISPLAY "produit :" fdi_produit
                       DISPLAY "quantite:" fdi_quantite
             END-READ
           END-PERFORM
           CLOSE fdistributions.




       Suppression_distributions.
           OPEN I-O fdistributions
           MOVE 0 TO Wtrouver
           PERFORM WITH TEST AFTER UNTIL Wtrouver = 1
           DISPLAY "Entrez l'ID de la distribution à supprimer : "
           ACCEPT WidD
           MOVE WidD TO fdi_id
           READ fdistributions
           INVALID KEY
               DISPLAY "La distribution n'existe pas."
               MOVE 1 TO Wtrouver
           NOT INVALID KEY
               DISPLAY "La distribution a été supprimée."
               DELETE fdistributions
               MOVE 1 TO Wtrouver
           END-READ
           END-PERFORM
           CLOSE fdistributions.

       Modification_distributions.
           DISPLAY "Modification d'une distribution"
           DISPLAY "Entrez l'ID de la distribution à modifier : "
           ACCEPT WidD
           OPEN I-O fdistributions
           MOVE 0 TO Wtrouver
           MOVE WidD TO fdi_id
           PERFORM WITH TEST AFTER UNTIL Wtrouver = 1
           READ fdistributions KEY IS fdi_id
           AT END
               DISPLAY "Distribution non trouvée"
               MOVE 1 TO Wtrouver
           NOT AT END
               DISPLAY "Entrez le nouvel ID de groupe : "
               ACCEPT WidGroupe
               DISPLAY "Entrez la nouvelle date : "
               ACCEPT Wdate
               DISPLAY "Entrez le nouvel horaire : "
               ACCEPT Whoraire
               DISPLAY "Entrez l'ID du centre : "
               ACCEPT WidC
               DISPLAY "Entrez le nouveau produit : "
               ACCEPT Wproduit
               DISPLAY "Entrez la nouvelle quantité : "
               ACCEPT Wquantite
               MOVE WidGroupe TO fdi_idGroupe
               MOVE Wdate TO fdi_date
               MOVE Whoraire TO fdi_horaire
               MOVE WidC TO fdi_centre
               MOVE Wproduit TO fdi_produit
               MOVE Wquantite TO fdi_quantite
               REWRITE tamp_fdistributions
               END-REWRITE
               DISPLAY "Distribution modifiée"
           END-READ
           END-PERFORM
           CLOSE fdistributions.
       
