## Installation

Avant de commencer, il faut installer les dépendances suivantes : dbt Core, son adapter, et éventuellement Dagster pour l’orchestration.

### Installer dbt Core (avec pip)

```bash
pip install dbt-core
```

### Installer l’adapter correspondant à ta base de données

Remplace `<adapter>` par le bon nom de l’adapter :
- Pour DuckDB : `dbt-duckdb`
- Pour PostgreSQL : `dbt-postgres`
- Pour BigQuery : `dbt-bigquery`
- Pour Snowflake : `dbt-snowflake`
- Pour Databricks : `dbt-databricks`

**Exemple :**
```bash
pip install dbt-snowflake
```

### Installer Dagster et l'intégration dbt

```bash
pip install dagster dagster-webserver dagster-dbt
```

---

## DBT Cheat Sheet – Commandes Utiles

Voici les commandes dbt les plus fréquentes à utiliser dans ce projet :

### Initialiser & configurer le projet

```bash
dbt init nom_du_projet         # Initialise un nouveau projet dbt dans le dossier 'nom_du_projet'
dbt clean                      # Supprime les dossiers générés ('target/', 'dbt_modules/', etc.)
dbt deps                       # Installe les dépendances définies dans le projet (dossier 'dbt_packages/')
```

### Compilation, exécution et tests

```bash
dbt run                        # Exécute tous les modèles (models) du projet
dbt run --select my_model      # Exécute uniquement le modèle 'my_model'
dbt run --exclude my_model     # Exécute tous les modèles sauf 'my_model'

dbt build                      # Compile, exécute, seed, snapshot et teste tout le projet

dbt test                       # Lance tous les tests du projet
dbt test --select my_model     # Teste uniquement le modèle 'my_model'

dbt compile                    # Compile les fichiers SQL sans exécuter les requêtes

dbt seed                       # Charge les fichiers CSV présents dans le dossier 'data/' dans la base
```

### Documentation & analyse

```bash
dbt docs generate              # Génère la documentation statique
dbt docs serve                 # Lance un serveur local pour visualiser la documentation

dbt ls                         # Liste les ressources du projet selon des sélections
```

### Débogage & informations utiles

```bash
dbt debug                      # Teste la connexion et la configuration générale du projet
dbt source freshness           # Évalue la fraîcheur des données sources du projet
```

### Snapshots & opérations avancées

```bash
dbt snapshot                   # Exécute les snapshots (historisation de données)
dbt run-operation my_macro     # Lance une macro spécifique définie dans le projet
dbt run --full-refresh         # Reconstruit complètement les tables materialisées (DROP & CREATE)
```

---

> **Note :** Le dossier `target/` contient les fichiers générés à l'exécution et peut être supprimé sans risque via `dbt clean`. Il sera automatiquement régénéré lors de la prochaine exécution de `dbt run`, `dbt build`, ou commande équivalente.

---

## Dagster Cheat Sheet – Commandes Utiles

Voici les commandes Dagster les plus courantes à utiliser dans ce projet :

### Projet & structure

```bash
dagster-dbt project scaffold --project-name nom_du_projet  # Crée la structure de base d'un projet Dagster compatible dbt
dagster project scaffold                                   # Crée la structure de base d'un projet Dagster classique
```

### Démarrage et exploration

```bash
dagster dev                          # Démarre l'interface web Dagster en local
dagster job list                     # Liste les jobs définis dans le projet
dagster job execute -j <nom_du_job>  # Exécute le job spécifié
dagster asset list                   # Liste tous les assets du projet
dagster asset materialize            # Exécute tous les assets materializables
```

### Surveillance et planification

```bash
dagster run list                 # Liste les exécutions passées
dagster schedule list            # Liste les plannings (schedules) définis
dagster sensor list              # Liste les capteurs (sensors) définis
```

### Utilitaires

```bash
dagster instance info            # Infos sur l’instance Dagster en cours
dagster --help                   # Liste toutes les commandes disponibles
```

---

> **Note :**  
> Pour que Dagster trouve simplement la configuration de connexion dbt, il est conseillé de laisser le fichier `profiles.yml` dans le dossier du projet dbt.  
> **Attention :** Il est fortement recommandé d’exclure ce fichier du suivi git (ajoutez-le à `.gitignore`) afin d’éviter toute fuite d’identifiants ou de secrets de connexion.
