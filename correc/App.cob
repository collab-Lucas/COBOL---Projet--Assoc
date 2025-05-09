       IDENTIFICATION DIVISION.
       PROGRAM-ID. App.
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


        select fcentres assign to "centres.dat"
        organization indexed
        access mode is dynamic
        record key is fce_id
        alternate record key is fce_ville WITH DUPLICATES
        alternate record key is fce_produit WITH DUPLICATES
        file status is cr_fcentres.


        select fdistributions assign to "distributions.dat"
        organization indexed
        access mode is dynamic
        record key is fdi_id
        alternate record key is fdi_idGroupe WITH DUPLICATES
        alternate record key is fdi_centre WITH DUPLICATES
        alternate record key is fdi_produit WITH DUPLICATES
        file status is cr_fdistributions.


        select fgroupes assign to "groupes.dat"
        organization indexed
        access mode is dynamic
        record key is fgr_id
        alternate record key is fgr_specialite WITH DUPLICATES
        file status is cr_fgroupes.


        select fproduits assign to "produits.dat"
        organization indexed
        access mode is dynamic
        record key is fpr_id
        file status is cr_fproduits.


       DATA DIVISION.
         FILE SECTION.


       FD fbe.
              01 tamp_fbe.
                  02 fbe_id PIC 9(4).
                  02 fbe_idGroupe PIC 9(4).
                  02 fbe_role PIC 9(1).
                  02 fbe_nom PIC X(30).
                  02 fbe_prenom PIC X(30).
                  02 fbe_age PIC 9(3).
                  02 fbe_mdp PIC X(30).


       FD increment.
              01 autoinc.
                  02 autoinc_num PIC 9(4).


       FD fcentres.
           01 tamp_fcentres.
               02 fce_id PIC 9(2).
               02 fce_ville PIC X(30).
               02 fce_produit PIC 9(5).
               02 fce_nom PIC X(30).
               02 fce_quantite PIC 9(6).


       FD fdistributions.
              01 tamp_fdistributions.
                  02 fdi_id PIC 9(5).
                  02 fdi_idGroupe PIC 9(5).
                  02 fdi_jour PIC 9(2).
                  02 fdi_moi PIC 9(2).
                  02 fdi_annee PIC 9(2).
                  02 fdi_centre PIC 9(2).
                  02 fdi_horaire PIC X(2).
                  02 fdi_produit PIC 9(2).
                  02 fdi_quantite PIC 9(6).

       FD fgroupes.
              01 tamp_fgroupes.
                  02 fgr_id PIC 9(5).
                  02 fgr_specialite PIC X(30).
                  02 fgr_nbMembre PIC 9(4).


       FD fproduits.
              01 tamp_fproduits.
                  02 fpr_id PIC 9(5).
                  02 fpr_nom PIC X(30).
                  02 fpr_quantite PIC 9(6).




       WORKING-STORAGE SECTION.
                    77 cr_fdistributions PIC 9(2).
                    77 cr_fcentres PIC 9(2).
                    77 cr_fproduits PIC 9(2).
                    77 cr_fgroupes PIC 9(2).
                    77 cr_fbe PIC 9(2).
                    77 cr_autoinc PIC 9(2).
                    77 Wfin PIC 9.
                    77 Wid PIC 9(4).
                    77 Wrole PIC 9(1).
                    77 Wnom PIC X(30).
                    77 Wprenom PIC X(30).
                    77 Wage PIC 9(3).
                    77 Wmdp PIC X(30).
                    77 Wtrouver PIC 9(1).
                    77 Wtrouve PIC 9(1).
                    77 Wchoix PIC 9(1).
                    77 WchoixM PIC 9(1).
                    77 Wchoix2 PIC 9(1).
                    77 WidUtilisateurConnecte  PIC 9(4).
                    77 Wquantite PIC 9(6).
                    77 WidProduit PIC 9(5).
                    77 Wproduit PIC 9(2).
                    77 Wville PIC X(30).
                    77 WidC PIC 9(2).
                    77 WidG PIC 9(5).
                    77 Wspecialite PIC X(30).
                    77 WnbMembre PIC 9(4).
                    77 WroleUtilisateurConnecte PIC 9(1).
                    77 WidD PIC 9(5).
                    77 WidGroupe PIC 9(5).
                    77 Wdate PIC 9(8).
                    77 Whoraire PIC X(2).
                    77 WidUtilisateur PIC 9(4).
                    77 Wmot_de_passe PIC X(30).
                    77 WidGroupeUtili PIC 9(5).
                    77 WidcentrePIC PIC 9(2).


       PROCEDURE DIVISION.


       OPEN I-O increment
                  IF cr_autoinc = 35
                      MOVE 0 TO autoinc_num
                      WRITE autoinc
                      CLOSE increment
                  END-IF


       OPEN I-O fproduits
           IF cr_fproduits = 35 THEN
               OPEN OUTPUT fproduits

               MOVE 00001 TO fpr_id
               MOVE "Pommes" TO fpr_nom
               MOVE 150 TO fpr_quantite

               WRITE tamp_fproduits
               END-WRITE


               MOVE 00002 TO fpr_id
               MOVE "Oranges" TO fpr_nom
               MOVE 250 TO fpr_quantite

               WRITE tamp_fproduits
               END-WRITE

           END-IF
       CLOSE fproduits

       OPEN I-O fcentres
       IF cr_fcentres = 35 THEN
            OPEN OUTPUT fcentres

            MOVE 01 TO fce_id
            MOVE "Paris" TO fce_ville
            MOVE 00001 TO fce_produit
            MOVE "Centre Paris" TO fce_nom
            MOVE 10000 TO fce_quantite

            WRITE tamp_fcentres
            END-WRITE


            MOVE 02 TO fce_id
            MOVE "Lyon" TO fce_ville
            MOVE 00001 TO fce_produit
            MOVE "Centre Lyon" TO fce_nom
            MOVE 8000 TO fce_quantite

            WRITE tamp_fcentres
            END-WRITE

       END-IF
       CLOSE fcentres

       OPEN I-O fdistributions
       IF cr_fdistributions = 35 THEN
            OPEN OUTPUT fdistributions

            MOVE 00001 TO fdi_id
            MOVE 00001 TO fdi_idGroupe
            MOVE 01 TO fdi_jour
            MOVE 01 TO fdi_moi
            MOVE 23 TO fdi_annee
            MOVE "AM" TO fdi_horaire
            MOVE 01 TO fdi_produit
            MOVE 500 TO fdi_quantite

            WRITE tamp_fdistributions
            END-WRITE


            MOVE 00002 TO fdi_id
            MOVE 00002 TO fdi_idGroupe
            MOVE 01 TO fdi_jour
            MOVE 01 TO fdi_moi
            MOVE 23 TO fdi_annee
            MOVE "PM" TO fdi_horaire
            MOVE 02 TO fdi_produit
            MOVE 1000 TO fdi_quantite

            WRITE tamp_fdistributions
            END-WRITE

       END-IF
       CLOSE fdistributions


       OPEN I-O fgroupes
       IF cr_fgroupes = 35 THEN
            OPEN OUTPUT fgroupes

            MOVE 00001 TO fgr_id
            MOVE "Cuisine" TO fgr_specialite
            MOVE 10 TO fgr_nbMembre

            WRITE tamp_fgroupes
            END-WRITE


            MOVE 00002 TO fgr_id
            MOVE "Musique" TO fgr_specialite
            MOVE 15 TO fgr_nbMembre

            WRITE tamp_fgroupes
            END-WRITE

       END-IF
       CLOSE fgroupes


        OPEN I-O fbe
           IF cr_fbe = 35 THEN
                   OPEN I-O increment
              READ increment
                  ADD 2 TO autoinc_num
                  WRITE autoinc
                  END-WRITE


                MOVE 00001 TO fbe_id
                MOVE "Lucas" TO fbe_prenom
                MOVE "Bonneau" TO fbe_nom
                MOVE 00001 TO fbe_idGroupe
                MOVE 25 TO fbe_age
                MOVE 1 TO fbe_role
                MOVE "1" TO fbe_mdp

                WRITE tamp_fbe
                END-WRITE


                MOVE 00002 TO fbe_id
                MOVE "Mick" TO fbe_prenom
                MOVE "Dikke" TO fbe_nom
                   MOVE 00002 TO fbe_idGroupe
                MOVE 30 TO fbe_age
                MOVE 2 TO fbe_role
                MOVE "800" TO fbe_mdp

                WRITE tamp_fbe
                END-WRITE

           END-IF
           CLOSE increment
           CLOSE fbe

        PERFORM MENUCHOIX

        STOP RUN.

        COPY "menu.cpy".
        COPY "connexion.cpy".
        COPY "benevoles.cpy".
        COPY "centres.cpy".
        COPY "distributions.cpy".
        COPY "groupes.cpy".
        COPY "produits.cpy".
