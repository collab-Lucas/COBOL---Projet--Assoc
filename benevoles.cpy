       Ajout_BEN.
       DISPLAY  "Création d un nouveau bénévole "

       OPEN I-O fbe
       MOVE 0 TO Wtrouve
        PERFORM WITH TEST AFTER UNTIL Wtrouve = 0 AND Wid<>0
                MOVE 0 TO Wtrouve
                DISPLAY "Id Utilisateur: " WITH NO ADVANCING
                ACCEPT Wid
                MOVE Wid TO fbe_id
                READ fbe
                  NOT INVALID KEY
                        MOVE 1 TO Wtrouve
                        DISPLAY "⚠️ Id déjà utilisé ! ⚠️"
                END-READ
                IF Wid = 0 THEN
                        DISPLAY "⚠ Id doit être different de 0 !⚠"
                END-IF
        END-PERFORM

        MOVE 0 TO Wtrouve
        PERFORM WITH TEST AFTER UNTIL Wtrouve = 0 AND WidGroupe <> 0
                DISPLAY  "Entrez l ID du groupe (1 Si pas de groupe ):"
                ACCEPT WidGroupe
                
                MOVE 0 TO Wtrouve
                
                MOVE WidGroupe TO fbe_idGroupe

                OPEN INPUT fgroupes
                 MOVE WidGroupe TO fgr_id
                 READ fgroupes
                   INVALID KEY 
                   DISPLAY "groupe non trouver"
                   NOT INVALID KEY
                        MOVE 1 TO Wtrouve
                        MOVE WidGroupe TO fbe_idGroupe
                        DISPLAY "groupe trouver"
                 END-READ 
        END-PERFORM
           MOVE 0 TO Wtrouver
           PERFORM WITH TEST AFTER UNTIL Wtrouver = 1
               DISPLAY  "Entrez le rôle :  "
               ACCEPT Wrole
               IF Wrole >0 AND  Wrole >4
                   MOVE 1 TO Wtrouver
               END-IF
           END-PERFORM
           DISPLAY  "Entrez le nom :  "
           ACCEPT Wnom
           DISPLAY  "Entrez le prénom :  "
           ACCEPT Wprenom
           MOVE 0 TO Wtrouver
           PERFORM WITH TEST AFTER UNTIL Wtrouver = 1
               DISPLAY  "Entrez l âge :  "
               ACCEPT Wage
               IF Wage > 0
                   MOVE 1 TO Wtrouver
               END-IF
           END-PERFORM
           DISPLAY  "Entrez le mot de passe :  "
           ACCEPT Wmdp
           MOVE Wid TO fbe_id
           MOVE WidGroupe TO fbe_idGroupe
           MOVE Wrole TO fbe_role
           MOVE Wnom TO fbe_nom
           MOVE Wprenom TO fbe_prenom
           MOVE Wage TO fbe_age
           MOVE Wmdp TO fbe_mdp
           WRITE tamp_fbe
           END-WRITE
           CLOSE fbe
           CLOSE fgroupes.

       Affichage_benevoles.
           OPEN INPUT fbe
           MOVE 0 TO Wfin
           PERFORM WITH TEST AFTER UNTIL Wfin = 1
            READ fbe NEXT
            AT END MOVE 1 TO Wfin
            NOT AT END
                DISPLAY  "numéro: " fbe_id
                DISPLAY  "nom : " fbe_nom
            END-READ
           END-PERFORM
           CLOSE fbe.

       Suppression_benevoles.
           OPEN I-O fbe
           MOVE 0 TO Wtrouver
           PERFORM WITH TEST AFTER UNTIL Wtrouver = 1
            DISPLAY  "Entrez l ID du bénévole �  supprimer :  "
              ACCEPT Wid
              MOVE Wid TO fbe_id
              READ fbe
              INVALID KEY
                DISPLAY  "Le bénévole n existe pas. "
                 MOVE 1 TO Wtrouver
              NOT INVALID KEY
                DISPLAY  "Le bénévole a été supprimé. "
                DELETE fbe
                 MOVE 1 TO Wtrouver
              END-READ
           END-PERFORM
           CLOSE fbe.


       Modification_benevoles.
            DISPLAY  "Modification d un bénévole "
            DISPLAY  "Entrez l ID du bénévole à modifier :  "
            ACCEPT Wid
            OPEN I-O fbe
            MOVE 0 TO Wtrouver
            PERFORM WITH TEST AFTER UNTIL Wtrouver = 1
               READ fbe KEY IS Wid
               AT END
                   DISPLAY  "Bénévole non trouvé "
                   MOVE 1 TO Wtrouver
               NOT AT END
                   DISPLAY  "Entrez le nouveau groupe :  "
                   ACCEPT WidGroupe
                   DISPLAY  "Entrez le nouveau rôle :  "
                   ACCEPT Wrole
                   DISPLAY  "Entrez le nouveau nom :  "
                   ACCEPT Wnom
                   DISPLAY  "Entrez le nouveau prénom :  "
                   ACCEPT Wprenom
                   MOVE 0 TO Wtrouve
                   PERFORM WITH TEST AFTER UNTIL Wtrouve = 1
                      DISPLAY  "Entrez le nouvel âge :  "
                      ACCEPT Wage
                      IF Wage > 0
                          MOVE 1 TO Wtrouve
                      END-IF
                   END-PERFORM
                   DISPLAY  "Entrez le nouveau mot de passe :  "
                   ACCEPT Wmdp
                   MOVE Wid TO fbe_id
                   MOVE WidGroupe TO fbe_idGroupe
                   MOVE Wrole TO fbe_role
                   MOVE Wnom TO fbe_nom
                   MOVE Wprenom TO fbe_prenom
                   MOVE Wage TO fbe_age
                   MOVE Wmdp TO fbe_mdp
                   REWRITE tamp_fbe
                   END-REWRITE
                   DISPLAY  "Bénévole modifié "
               END-READ
            END-PERFORM
            CLOSE fbe.

        Ajout_au_Groupes.
            MOVE 0 TO Wtrouver
            PERFORM WITH TEST AFTER UNTIL Wtrouver = 1
               DISPLAY  "Entrez l ID du bénévole à ajouter au groupe:  "
               ACCEPT Wid
               OPEN I-O fbe
               MOVE Wid TO fbe_id
               READ fbe 
                   INVALID KEY 
                       DISPLAY "id non trouver"
                   NOT INVALID KEY
                        MOVE 1 TO Wtrouver
                        DISPLAY "id trouver"
               END-READ
            END-PERFORM

            MOVE 0 TO Wtrouve
        PERFORM WITH TEST AFTER UNTIL Wtrouve = 0 AND WidGroupe <> 0
                DISPLAY  "Entrez l ID du groupe (1 Si pas de groupe ):"
                ACCEPT WidGroupe
                
                MOVE 0 TO Wtrouve

                OPEN INPUT fgroupes
                MOVE WidGroupe TO fgr_id
                READ fgroupes
                   INVALID KEY 
                   DISPLAY "groupe non trouver"
                   NOT INVALID KEY
                        MOVE 1 TO Wtrouve
                        MOVE WidGroupe TO fbe_idGroupe
                        DISPLAY "groupe trouver"
                 END-READ 
        END-PERFORM

                MOVE WidGroupe TO fbe_idGroupe
                REWRITE tamp_fbe
                END-REWRITE
                DISPLAY  "Ajouter au groupe modifié "
            CLOSE fbe.

       GERE_BENEVOLES.
       MOVE 0 TO Wchoix2
       PERFORM WITH TEST AFTER UNTIL Wchoix2 < 6 AND Wchoix2 >0
           DISPLAY  "1. Ajouter Bénévoles "
           DISPLAY  "2. Supprimer Bénévoles "
		   DISPLAY  "3. Modifier Bénévoles "
           DISPLAY  "4. Afficher Bénévoles "
           DISPLAY  "5.Sortir "
           ACCEPT Wchoix2
           IF Wchoix2= 1 THEN
               PERFORM Ajout_BEN
           ELSE IF Wchoix2= 2 THEN
               PERFORM Suppression_benevoles
           ELSE IF Wchoix2= 3 THEN
               PERFORM Modification_benevoles
           ELSE IF Wchoix2= 4 THEN
               PERFORM Affichage_benevoles
           ELSE IF Wchoix2= 5 THEN
                DISPLAY "✅️ Sortie menu ✅️"
           END-IF
       END-PERFORM.

       GERE_GROUPES.
        MOVE 0 TO Wchoix2
       PERFORM WITH TEST AFTER UNTIL Wchoix2 < 6 AND Wchoix2 >0
           DISPLAY  "1. Ajouter Groupes "
           DISPLAY  "2. Supprimer Groupes "
		   DISPLAY  "3. Modifier Groupes "
           DISPLAY  "4. Afficher Groupes "
           DISPLAY  "5.Sortir"
           ACCEPT Wchoix2
           IF Wchoix2= 1 THEN
               PERFORM Ajout_groupes
           ELSE IF Wchoix2= 2 THEN
               PERFORM Suppression_groupes
           ELSE IF Wchoix2= 3 THEN
               PERFORM Modification_groupes
           ELSE IF Wchoix2= 4 THEN
               PERFORM Affichage_groupes
           ELSE IF Wchoix2= 5 THEN
                DISPLAY "✅️ Sortie menu ✅️"
           END-IF
       END-PERFORM.

       GERE_CENTRES.
        MOVE 0 TO Wchoix2
       PERFORM WITH TEST AFTER UNTIL Wchoix2 < 6 AND Wchoix2 >0
           DISPLAY  "1. Ajouter Centres "
           DISPLAY  "2. Supprimer Centres "
           DISPLAY  "3. Modifier Centres "
		   DISPLAY  "4. Afficher Centres "
           DISPLAY  "5.Sortir "
           ACCEPT Wchoix2
           IF Wchoix2= 1 THEN
               PERFORM Ajout_centres
           ELSE IF Wchoix2= 2 THEN
               PERFORM Suppression_centres
           ELSE IF Wchoix2= 3 THEN
               PERFORM Modification_centres
           ELSE IF Wchoix2= 4 THEN
               PERFORM Affichage_centres
           ELSE IF Wchoix2= 5 THEN
                DISPLAY "✅️ Sortie menu ✅️"
           END-IF
       END-PERFORM.

       GERE_DISTRI.
        MOVE 0 TO Wchoix2
       PERFORM WITH TEST AFTER UNTIL Wchoix2 < 6 AND Wchoix2 >0
           DISPLAY  "1. Ajouter distribution "
           DISPLAY  "2. Supprimer distribution "
           DISPLAY  "3. Modifier distribution "
		   DISPLAY  "4. Afficher distribution "
           DISPLAY  "5.Sortir "
           ACCEPT Wchoix2
           IF Wchoix2= 1 THEN
               PERFORM Ajout_distributions
           ELSE IF Wchoix2= 2 THEN
               PERFORM Suppression_distributions
           ELSE IF Wchoix2= 3 THEN
               PERFORM Modification_distributions
           ELSE IF Wchoix2= 4 THEN
               PERFORM Affichage_distributions
           ELSE IF Wchoix2= 5 THEN
                DISPLAY "✅️ Sortie menu ✅️"
           END-IF
       END-PERFORM.

       GERE_PRODUIT.
        MOVE 0 TO Wchoix2
       PERFORM WITH TEST AFTER UNTIL Wchoix2 < 6 AND Wchoix2 >0
           DISPLAY  "1. Ajouter produit "
           DISPLAY  "2. Supprimer produit "
           DISPLAY  "3. Modifier produit "
		   DISPLAY  "4. Afficher produit "
           DISPLAY  "5.Sortir "
           ACCEPT Wchoix2
           IF Wchoix2= 1 THEN
               PERFORM Ajout_produits
           ELSE IF Wchoix2= 2 THEN
               PERFORM Suppression_produits
           ELSE IF Wchoix2= 3 THEN
               PERFORM Modification_produits
           ELSE IF Wchoix2= 4 THEN
               PERFORM Affichage_produits
           ELSE IF Wchoix2= 5 THEN
                DISPLAY "✅️ Sortie menu ✅️"
           END-IF
       END-PERFORM.
