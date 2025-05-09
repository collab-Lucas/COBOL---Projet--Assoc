       Ajout_groupes.
           OPEN I-O increment
           READ increment
               ADD 1 TO autoinc_num
               WRITE autoinc
           CLOSE increment

           DISPLAY "Création d'un nouveau groupe"

           OPEN I-O fgroupes
               MOVE 0 TO Wtrouver
               DISPLAY "Entrez l'ID du groupe : "
               ACCEPT WidG
               DISPLAY "Entrez la spécialité : "
               ACCEPT Wspecialite
               DISPLAY "Entrez le nombre de membres : "
               ACCEPT WnbMembre
               MOVE Wid TO fgr_id
               MOVE Wspecialite TO fgr_specialite
               MOVE WnbMembre TO fgr_nbMembre
               WRITE tamp_fgroupes
               END-WRITE
           CLOSE fgroupes.

       Affichage_groupes.
           OPEN INPUT fgroupes
           MOVE 0 TO Wfin
           PERFORM WITH TEST AFTER UNTIL Wfin = 1
               READ fgroupes NEXT
               AT END MOVE 1 TO Wfin
               NOT AT END
                   DISPLAY "ID du groupe :" fgr_id
                   DISPLAY "Spécialité :" fgr_specialite
                   DISPLAY "Nombre de membres :" fgr_nbMembre
               END-READ
           END-PERFORM
           CLOSE fgroupes.

       Suppression_groupes.
           OPEN I-O fgroupes
           MOVE 0 TO Wtrouver
           PERFORM WITH TEST AFTER UNTIL Wtrouver = 1
               DISPLAY "Entrez l'ID du groupe à supprimer : "
               ACCEPT fgr_id
               READ fgroupes
               INVALID KEY
                   DISPLAY "Le groupe n'existe pas."
                   MOVE 1 TO Wtrouver
               NOT INVALID KEY
                   DISPLAY "Le groupe a été supprimé."
                   DELETE fgroupes
                   MOVE 1 TO Wtrouver
               END-READ
           END-PERFORM
           CLOSE fgroupes.

       Modification_groupes.
           DISPLAY "Modification d'un groupe"
           DISPLAY "Entrez l'ID du groupe à modifier : "
           ACCEPT WidG
           OPEN I-O fgroupes
           MOVE 0 TO Wtrouver
           MOVE WidG TO fgr_id
           PERFORM WITH TEST AFTER UNTIL Wtrouver = 1
               READ fgroupes KEY IS fgr_id
               AT END
                   DISPLAY "Groupe non trouvé"
                   MOVE 1 TO Wtrouver
               NOT AT END
                   DISPLAY "Entrez la nouvelle spécialité : "
                   ACCEPT Wspecialite
                   DISPLAY "Entrez le nouveau nombre de membres : "
                   ACCEPT WnbMembre
                   MOVE Wspecialite TO fgr_specialite
                   MOVE WnbMembre TO fgr_nbMembre
                   REWRITE tamp_fgroupes
                   END-REWRITE
                   DISPLAY "Groupe modifié"
               END-READ
           END-PERFORM
           CLOSE fgroupes.