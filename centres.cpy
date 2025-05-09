       Ajout_centres.
       OPEN I-O increment
       READ increment
           ADD 1 TO autoinc_num
           WRITE autoinc
       CLOSE increment

       DISPLAY "Création d'un nouveau centre"

       OPEN I-O fcentres
          MOVE 0 TO Wtrouver
          DISPLAY "Entrez l'ID du centre : "
          ACCEPT fce_id
          DISPLAY "Entrez la ville : "
          ACCEPT fce_ville
          DISPLAY "Entrez le produit : "
          ACCEPT fce_produit
          DISPLAY "Entrez le nom : "
          ACCEPT fce_nom
          DISPLAY "Entrez la quantité : "
          ACCEPT fce_quantite
          MOVE WidC TO fce_id
          MOVE Wville TO fce_ville
          MOVE Wproduit TO fce_produit
          MOVE Wnom TO fce_nom
          MOVE Wquantite TO fce_quantite
          WRITE tamp_fcentres
          END-WRITE
          CLOSE fcentres.

              Affichage_centres.
        OPEN INPUT fcentres
        MOVE 0 TO Wfin
        PERFORM WITH TEST AFTER UNTIL Wfin = 1
         READ fcentres NEXT
         AT END MOVE 1 TO Wfin
         NOT AT END
             DISPLAY "ID :" fce_id
             DISPLAY "Nom :" fce_nom
         END-READ
        END-PERFORM
        CLOSE fcentres.

            Suppression_centres.
        OPEN I-O fcentres
        MOVE 0 TO Wtrouver
        PERFORM WITH TEST AFTER UNTIL Wtrouver = 1
         DISPLAY "Entrez l'ID du centre à supprimer : "
           ACCEPT fce_id
           READ fcentres
           INVALID KEY
             DISPLAY "Le centre n'existe pas."
              MOVE 1 TO Wtrouver
           NOT INVALID KEY
             DISPLAY "Le centre a été supprimé."
             DELETE fcentres
              MOVE 1 TO Wtrouver
           END-READ
        END-PERFORM
        CLOSE fcentres.

         Modification_centres.
         DISPLAY "Modification d'un centre"
         DISPLAY "Entrez l'ID du centre à modifier : "
         ACCEPT fce_id
         OPEN I-O fcentres
         MOVE 0 TO Wtrouver
         PERFORM WITH TEST AFTER UNTIL Wtrouver = 1
         READ fcentres KEY IS fce_id
         AT END
             DISPLAY "Centre non trouvé"
             MOVE 1 TO Wtrouver
         NOT AT END
             DISPLAY "Entrez la nouvelle ville : "
             ACCEPT fce_ville
             DISPLAY "Entrez le nouveau produit : "
             ACCEPT fce_produit
             DISPLAY "Entrez le nouveau nom : "
             ACCEPT fce_nom
             DISPLAY "Entrez la nouvelle quantité : "
             ACCEPT fce_quantite
             MOVE WidC TO fce_id
             MOVE Wville TO fce_ville
             MOVE Wproduit TO fce_produit
             MOVE Wnom TO fce_nom
             MOVE Wquantite TO fce_quantite
             REWRITE tamp_fcentres
             END-REWRITE
             DISPLAY "Centre modifié"
         END-READ
         END-PERFORM
         CLOSE fcentres.