           IDENTIFICATION DIVISION.
              PROGRAM-ID. benevoles.
              ENVIRONMENT DIVISION.
              INPUT-OUTPUT SECTION.
              FILE-CONTROL.

                  select fbe assign to "benevoles.dat"
                  organization indexed
                  access mode is dynamic
                  record key is fbe_id
                  alternate record key is fbe_idGroupe WITH DUPLICATES
                  alternate record key is fbe_role WITH DUPLICATES
                  file status is cr_fbe.

                  select increment assign to "autoinc.dat"
                  organization indexed
                  access mode is dynamic
                  record key is autoinc_num
                  file status is cr_autoinc.

              DATA DIVISION.
              FILE SECTION.

              FD fbe.
              01 tamp_fbe.
                  02 fbe_id PIC 9(4).
                  02 fbe_idGroupe PIC 9(4).
                  02 fbe_role PIC X(30).
                  02 fbe_nom PIC X(30).
                  02 fbe_prenom PIC X(30).
                  02 fbe_age PIC 9(3).
                  02 fbe_mdp PIC X(30).

              FD increment.
              01 autoinc.
                  02 autoinc_num PIC 9(4).

              WORKING-STORAGE SECTION.
              77 cr_fbe PIC 9(2).
              77 cr_autoinc PIC 9(2).
              77 Wfin PIC 9.
              77 Wid PIC 9(4).
              77 WidGroupe PIC 9(4).
              77 Wrole PIC X(30).
              77 Wnom PIC X(30).
              77 Wprenom PIC X(30).
              77 Wage PIC 9(3).
              77 Wmdp PIC X(30).
              77 Wtrouver PIC 9.

              PROCEDURE DIVISION.
              OPEN I-O increment
                  IF cr_autoinc = 35
                      MOVE 0 TO autoinc_num
                      WRITE autoinc
                      CLOSE increment
                  END-IF

              OPEN I-O fbe
                  IF cr_fbe = 35
                      OPEN OUTPUT fbe
                      CLOSE fbe
                  END-IF

              PERFORM Ajout_benevoles
              PERFORM Affichage_benevoles
              PERFORM Suppression_benevoles
              CLOSE fbe
              STOP RUN.

              Ajout_benevoles.
              OPEN INPUT increment
              READ increment
                  ADD 1 TO autoinc_num
                  WRITE autoinc
              CLOSE increment


               DISPLAY "Création d'un nouveau bénévole"

               OPEN INPUT fbe
           MOVE 0 TO Wtrouver
           CLOSE fbe
           DISPLAY "Entrez l'ID du groupe : "
           ACCEPT WidGroupe
           DISPLAY "Entrez le rôle : "
           ACCEPT Wrole
           DISPLAY "Entrez le nom : "
           ACCEPT Wnom
           DISPLAY "Entrez le prénom : "
           ACCEPT Wprenom
           MOVE 0 TO Wtrouver
           PERFORM WITH TEST AFTER UNTIL Wtrouver = 0
               DISPLAY "Entrez l'âge : "
               ACCEPT Wage
               IF Wage > 0
                   MOVE 0 TO Wtrouver
               END-IF
           END-PERFORM
           DISPLAY "Entrez le mot de passe : "
           ACCEPT Wmdp
           MOVE Wid TO fbe_id
           MOVE WidGroupe TO fbe_idGroupe
           MOVE Wrole TO fbe_role
           MOVE Wnom TO fbe_nom
           MOVE Wprenom TO fbe_prenom
           MOVE Wage TO fbe_age
           OPEN EXTEND fbe
           WRITE tamp_fbe
           END-WRITE
           CLOSE fbe.

               Affichage_benevoles.
           OPEN INPUT fbe
           MOVE 0 TO Wfin
           PERFORM WITH TEST AFTER UNTIL Wfin = 1
                  READ fbe NEXT
                         AT END MOVE 1 TO Wfin
                         NOT AT END
                                DISPLAY "numéro:" fbe_id
                                DISPLAY "nom :" fbe_nom
                  END-READ
           END-PERFORM
           CLOSE fbe.

               Suppression_benevoles.
           OPEN I-O fbe
           MOVE 0 TO Wtrouver
           PERFORM WITH TEST AFTER UNTIL Wtrouver = 1
                  DISPLAY "Entrez l'ID du bénévole �  supprimer : "
                  ACCEPT Wid
                  MOVE Wid TO fbe_id
                  READ fbe
                  INVALID KEY
                         DISPLAY "Le bénévole n'existe pas."
                         MOVE 1 TO Wtrouver
                  NOT INVALID KEY
                         DISPLAY "Le bénévole a été supprimé."
                         DELETE fbe
                  MOVE 1 TO Wtrouver
                  END-READ
           END-PERFORM
           CLOSE fbe.
