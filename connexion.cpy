       CONNEXION.

        DISPLAY " CONNEXION "
        DISPLAY "NUMERO D'IDENTIFIANT (id): " 
        ACCEPT WidUtilisateur
        DISPLAY WidUtilisateur
        DISPLAY "MOT DE PASSE : " WITH NO ADVANCING
        ACCEPT Wmot_de_passe
        DISPLAY Wmot_de_passe
        
        OPEN INPUT fbe
        
        MOVE WidUtilisateur TO fbe_id
        READ fbe KEY IS fbe_id
          INVALID KEY
           DISPLAY "⚠️ L'utilisateur n'existe pas ! ⚠️"
          NOT INVALID KEY
           IF fbe_mdp = Wmot_de_passe THEN
                MOVE WidUtilisateur TO WidUtilisateurConnecte
                MOVE fbe_idGroupe TO WidGroupeUtili
                MOVE fbe_role TO WroleUtilisateurConnecte
                DISPLAY "✅️ Connexion réussi ! ✅️"
                DISPLAY "➡️ Connecté en tant que" WITH NO ADVANCING
                IF fbe_role = 1 THEN
                        DISPLAY " ADMINISTRATEUR "
                ELSE IF fbe_role = 2 THEN
                        DISPLAY " BENEVOLES "
                ELSE IF fbe_role = 3 THEN
                        DISPLAY " CHEF DE GROUPE "
                END-IF
           ELSE
                DISPLAY "⚠️ Mot de passe incorrect ! ⚠️"
           END-IF
        END-READ
        
       CLOSE fbe.