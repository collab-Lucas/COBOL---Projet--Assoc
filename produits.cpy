       Ajout_produits.

       DISPLAY "Création d'un nouveau produit"

       OPEN I-O fproduits
           MOVE 0 TO Wtrouver
           DISPLAY "Entrez l'ID du produit : "
           ACCEPT WidProduit
           DISPLAY "Entrez le nom : "
           ACCEPT Wnom
           MOVE 0 TO Wtrouver
           PERFORM WITH TEST AFTER UNTIL Wtrouver = 1
               DISPLAY "Entrez la quantité : "
               ACCEPT Wquantite
               IF Wquantite > 0
                   MOVE 1 TO Wtrouver
               END-IF
           END-PERFORM
           MOVE WidProduit TO fpr_id
           MOVE Wnom TO fpr_nom
           MOVE Wquantite TO fpr_quantite
           WRITE tamp_fproduits
           END-WRITE
           CLOSE fproduits.

       Affichage_produits.
           OPEN INPUT fproduits
           MOVE 0 TO Wfin
           PERFORM WITH TEST AFTER UNTIL Wfin = 1
            READ fproduits NEXT
            AT END MOVE 1 TO Wfin
            NOT AT END
                DISPLAY "ID:" fpr_id
                DISPLAY "nom :" fpr_nom
            END-READ
           END-PERFORM
           CLOSE fproduits.

       Suppression_produits.
           OPEN I-O fproduits
           MOVE 0 TO Wtrouver
           PERFORM WITH TEST AFTER UNTIL Wtrouver = 1
            DISPLAY "Entrez l'ID du produit à supprimer : "
              ACCEPT WidProduit
              MOVE WidProduit TO fpr_id
              READ fproduits
              INVALID KEY
                DISPLAY "Le produit n'existe pas."
                 MOVE 1 TO Wtrouver
              NOT INVALID KEY
                DISPLAY "Le produit a été supprimé."
                DELETE fproduits
                 MOVE 1 TO Wtrouver
              END-READ
           END-PERFORM
           CLOSE fproduits.

       Modification_produits.
            DISPLAY "Modification d'un produit"
            DISPLAY "Entrez l'ID du produit à modifier : "
            ACCEPT WidProduit
            OPEN I-O fproduits
            MOVE 0 TO Wtrouver
            PERFORM WITH TEST AFTER UNTIL Wtrouver = 1
            READ fproduits KEY IS WidProduit
            AT END
                DISPLAY "Produit non trouvé"
                MOVE 1 TO Wtrouver
            NOT AT END
                DISPLAY "Entrez le nouveau nom : "
                ACCEPT Wnom
                MOVE 0 TO Wtrouver
                PERFORM WITH TEST AFTER UNTIL Wtrouver = 1
                DISPLAY "Entrez la nouvelle quantité : "
                ACCEPT Wquantite
                IF Wquantite > 0
                    MOVE 1 TO Wtrouver
                END-IF
                END-PERFORM
                MOVE WidProduit TO fpr_id
                MOVE Wnom TO fpr_nom
                MOVE Wquantite TO fpr_quantite
                REWRITE tamp_fproduits
                END-REWRITE
                DISPLAY "Produit modifié"
            END-READ
            END-PERFORM
            CLOSE fproduits.