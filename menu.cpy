        MENUCHOIX.
        MOVE 0 TO Wchoix

        DISPLAY "Bienvenue dans l application  de l association"
        DISPLAY " ------------------Kermito--------------------"

        MOVE 0 TO WidUtilisateurConnecte

        PERFORM WITH TEST AFTER UNTIL Wchoix = 0
            IF WidUtilisateurConnecte = 0 THEN
                DISPLAY "Connexion ou inscription"
                DISPLAY "1 Connexion"
                DISPLAY "2. Quitter le programme"

                PERFORM WITH TEST AFTER UNTIL Wchoix < 3 AND Wchoix > 0
                        DISPLAY "Choix: " WITH NO ADVANCING
                        ACCEPT Wchoix
                END-PERFORM

                        IF Wchoix = 1 THEN
                                PERFORM Ajout_BEN
                        ELSE IF Wchoix = 2 THEN
                                MOVE 0 TO Wchoix
                        END-IF
            ELSE

              DISPLAY  "  "
              DISPLAY "Application ::::::::::: Kermito "

              IF WroleUtilisateurConnecte = 1 THEN
                PERFORM WITH TEST AFTER UNTIL WchoixM < 7 AND WchoixM >0
                DISPLAY "1. Gérer Bénévole"
                DISPLAY "2. Gérer Groupe"
                DISPLAY "3. Gérer Centre"
                DISPLAY "4. Gérer Distribution"
                DISPLAY "5. Gérer Produit"
                DISPLAY "6.Sortir"
                        DISPLAY "Choix: " WITH NO ADVANCING
                        ACCEPT WchoixM
                END-PERFORM
                IF Wchoix = 1 THEN
                         PERFORM GERE_BENEVOLES
                ELSE IF Wchoix = 2 THEN
                        PERFORM GERE_GROUPES
                ELSE IF Wchoix = 3 THEN
                        PERFORM GERE_CENTRES
                ELSE IF Wchoix = 4 THEN
                        PERFORM GERE_DISTRI
                ELSE IF Wchoix = 5 THEN
                        PERFORM GERE_PRODUIT
                ELSE IF Wchoix = 6 THEN
                        MOVE 0 TO WidUtilisateurConnecte
                        DISPLAY  "✅️ Deconnexion réussi ✅️ "
                END-IF
              ELSE IF WroleUtilisateurConnecte = 2 THEN

                DISPLAY  "1. Modifier Groupes "
                DISPLAY  "2. Voir Groupes "
				DISPLAY  "3. Modif profil "
                DISPLAY  "4. Stats "
                DISPLAY  "5. Deconnexion "

                PERFORM WITH TEST AFTER UNTIL Wchoix < 6 AND Wchoix > 0
                        DISPLAY  "Choix:  " WITH NO ADVANCING
                        ACCEPT Wchoix
                END-PERFORM

                IF Wchoix = 1 THEN
                ELSE IF Wchoix = 2 THEN
                        
                ELSE IF Wchoix = 3 THEN
                        
			    ELSE IF Wchoix = 4 THEN
					   
                ELSE IF Wchoix = 5 THEN
                        MOVE 0 TO WidUtilisateurConnecte
                        DISPLAY  "✅️ Deconnexion réussi ✅️ "
                END-IF
            *>----MENU BENEVOLES----
              ELSE IF WroleUtilisateurConnecte = 3 THEN
                DISPLAY  "1. Voir distribution "
                DISPLAY  "2. Modif profil "
                DISPLAY  "3. Affichage groupes "
                DISPLAY  "4. Deconnexion "
                PERFORM WITH TEST AFTER UNTIL Wchoix < 5 AND Wchoix > 0
                        DISPLAY  "Choix:  " WITH NO ADVANCING
                        ACCEPT Wchoix
                END-PERFORM

                IF Wchoix = 1 THEN
                        
                ELSE IF Wchoix = 2 THEN
                        
                ELSE IF Wchoix = 3 THEN
                        
                ELSE IF Wchoix = 4 THEN
                        MOVE 0 TO WidUtilisateurConnecte
                        DISPLAY  "✅️ Deconnexion réussi ✅️ "
                END-IF
              END-IF
            END-IF
        END-PERFORM
        DISPLAY  "👋️~~Au revoir~~👋️ ".
