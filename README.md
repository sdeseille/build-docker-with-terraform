# Création d'infra Docker avec Terraform

Je m'appuies sur les articles référencés par ces URLs:

- <https://developer.hashicorp.com/terraform/tutorials/docker-get-started/install-cli>
- <https://developer.hashicorp.com/terraform/tutorials/docker-get-started/docker-build>

## Installation de Terraform sur Linux

La version Linux que j'utilise est Ubuntu 22.04 LTS.

```bash
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 22.04 LTS
Release:        22.04
Codename:       jammy
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$
```

### Mise à jour du système avant installation

On utilise la commande

```raw
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```

Résultat:

```bash
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$ sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
Hit:1 https://download.docker.com/linux/ubuntu jammy InRelease
Hit:2 http://security.ubuntu.com/ubuntu jammy-security InRelease
Hit:3 http://archive.ubuntu.com/ubuntu jammy InRelease
Hit:4 https://ppa.launchpadcontent.net/ansible/ansible/ubuntu jammy InRelease
Hit:5 http://archive.ubuntu.com/ubuntu jammy-updates InRelease
Hit:6 http://archive.ubuntu.com/ubuntu jammy-backports InRelease
Reading package lists... Done
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
gnupg is already the newest version (2.2.27-3ubuntu2.1).
software-properties-common is already the newest version (0.99.22.3).
0 upgraded, 0 newly installed, 0 to remove and 65 not upgraded.
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$
```

### Installation de la clé GPG d'Hashicorp

On utilise la commande:

```raw
wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
```

Résultat:

```bash
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$ wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
--2022-12-12 10:40:08--  https://apt.releases.hashicorp.com/gpg
Resolving apt.releases.hashicorp.com (apt.releases.hashicorp.com)... 18.244.179.43, 18.244.179.53, 18.244.179.89, ...
Connecting to apt.releases.hashicorp.com (apt.releases.hashicorp.com)|18.244.179.43|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 3195 (3.1K) [binary/octet-stream]
Saving to: ‘STDOUT’

-                                   100%[===================================================================>]   3.12K  --.-KB/s    in 0s

2022-12-12 10:40:08 (36.1 MB/s) - written to stdout [3195/3195]

^▒N▒▒KS▒z̕'Վxq▒▒rU
▒▒▒▒5c<▒▒STi▒▒▒▒3▒M▒▒3۲▒N▒▒diȾ▒즲▒▒ǂ▒W▒z▒▒▒L▒U▒▒▒▒&▒~a=▒▒Db▒"{AK▒C▒o▒▒ɱ▒T▒|-AF.▒hz▒7▒▒L▒C▒L▒▒׫▒▒R▒▒;▒▒▒▒▒\▒@ha▒▒bqQM
▒M▒▒▒▒kx+▒@▒▒▒)▒▒K4▒▒t▒▒DW▒▒▒T2-Bm▒*Tw▒C▒b▒▒+▒o▒]Z▒ԁ▒W▒w"▒5▒®
                                                             z▒▒▒r▒▒▒▒▒▒հ▒(▒͜▒G`F▒O▒~▒▒▒▒K▒▒o.▒▒h▒)▒6▒B▒ȯ▒IE▒á-▒▒▒▒▒▒▒▒▒S▒6▒▒<O+▒:3▒▒Q]▒▒▒▒縚▒8▒▒娮▒Y▒*▒ϼ▒B&▒m▒9{▒▒▒{▒▒l`K▒*Ǝ▒
▒p▒^▒O▒QHashiCorp Security (HashiCorp Package Signing) <security+packaging@hashicorp.com>▒8!▒2▒▒▒▒N▒▒▒p▒A▒▒▒!▒{^▒N▒



        ▒A▒▒▒!▒{▒▒▒]L▒▒9(#▒<▒▒r~K▒s▒Di▒▒▒WI2▒▒jB▒̤mˇ\▒▒b▒▒3@▒ZgilX▒?
▒ao▒c▒▒G▒_▒▒ H▒▒▒<kS9▒$▒/ٮξ▒]▒g▒▒};▒3!_▒C▒V`(j▒▒▒[㝍▒▒▒▒
                                               I[▒▒S9▒▒▒:J7▒▒drs▒▒▒▒L▒▒R▒▒▒-'1MV▒▒>H▒▒▒ӌ{▒n ▒▒
                                                                                              ▒G▒▒▒J▒▒▒i▒▒▒▒▒1▒▒▒▒Ucn▒▒▒3yxm2▒,Ƭ%▒▒▒Fz)▒▒aM}▒▒D#▒ɿ▒▒م▒`▒        ▒2K▒▒u▒Z▒hkA▒▒`T▒.▒▒D;\▒▒0O▒▒▒▒6▒KLrx*l▒▒k@▒#42▒▒h
▒▒(▒飺U
^▒N▒▒▒▒▒}/tGқY▒▒▒▒▒@Q▒`▒▒]I▒▒njn▒4▒▒[/7▒f\-u▒▒▒▒▒▒▒G'▒k▒R@Kor5sf▒▒U?▒*,+O▒▒E▒▒▒%▒S▒▒ٲ▒HGd'▒v6▒{ W▒W▒&v8▒ ▒▒<ay▒▒/?
nC▒▒▒▒8L#▒,▒▒▒▒p▒|eN)p▒▒W]      D#▒&v▒▒R▒W\
                                           ▒-p▒▒hA▒@▒g^▒q▒#▒▒▒▒▒Ac▒▒C▒▒P=kZ▒▒E▒P▒UVvC▒▒[B|_▒▒Aډ]y▒9     t▒$#&   Yֆ▒
                                                                                                                   [▒9▒_ǘ▒Wv▒▒l@▒B▒EB▒▒=S▒▒?tVE▒?▒l▒▒▒hm▒*i6y▒Z[▒B▒▒▒▒▒▒8A▒u▒j׼ȉ/x▒▒α;^▒▒^▒ʥ▒▒▒▒▒!▒~
                                                    ▒wmF▒@▒▒vY▒▒▒▒▒▒Z▒嫁?       ▒▒Y▒-u▒▒bS▒Ce▒ͭ▒0▒KB▒▒B▒▒zD▒*▒▒▒i▒▒▒3▒▒"%▒▒▒▒.▒@e▒կ▒1Z|▒^▒▒O▒]▒"J▒▒▒P▒▒a▒▒/7▒▒n▒iw<▒Q▒30▒▒9▒▒&(▒[▒▒P▒01Z▒Stp▒▒瞐v▒C▒▒▒|jW▒▒▒▒▒ !▒2▒▒▒▒N▒▒▒p▒A▒▒▒!▒{^▒N▒

        A▒▒▒!▒{▒▒▒▒J▒B▒t▒R▒Q▒Uk▒@▒x▒7▒▒▒▒zjoW▒▒▒0!r▒X▒V;▒V=▒▒▒▒M▒▒o▒▒發ԼR▒]Ixh▒▒Ƌ?▒t▒▒▒▒=▒▒▒s▒
                                                                                              ▒▒▒I▒<▒▒u8▒F;▒[▒▒9▒ش▒5▒;▒u▒Kx▒▒O▒▒_▒O▒%/ߨ▒▒^y?▒p*▒▒▒▒▒▒w/▒Iwbz▒(▒▒▒\▒▒▒+▒▒Tj▒c▒▒<▒▒O▒▒qʣ▒r▒o▒h͘YJ▒?l▒j▒▒▒gSl▒▒▒:▒▒5Q3▒s0▒ĸy-▒▒w▒(▒▒▒▒N*▒▒▒8ڍ▒▒▒▒ȹgu▒{▒▒*x?▒p▒*:a▒?~▒ubr▒Б▒▒▒;A▒▒▒▒▒▒F▒b7
        ▒▒▒▒O▒"▒▒▒
                  ]X▒İY▒u5▒tӺzĳ▒▒|▒!▒▒▒▒f▒▒*8▒▒QH▒[l▒▒▒▒:c`i▒▒▒▒K▒]▒▒▒!J:▒▒▒%
                                                                             *;▒аi(?▒▒ȳ▒▒▒▒>▒▒▒|k!JD▒k"`▒s▒jĬ~vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$
```

### Vérification de l'empreinte de la clé GPG Hashicorp

On utilise la commande:

```raw
gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint
```

Résultat:

```bash
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$ gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint
gpg: directory '/home/vagrant/.gnupg' created
gpg: /home/vagrant/.gnupg/trustdb.gpg: trustdb created
/usr/share/keyrings/hashicorp-archive-keyring.gpg
-------------------------------------------------
pub   rsa4096 2020-05-07 [SC]
      E8A0 32E0 94D8 EB4E A189  D270 DA41 8C88 A321 9F7B
uid           [ unknown] HashiCorp Security (HashiCorp Package Signing) <security+packaging@hashicorp.com>
sub   rsa4096 2020-05-07 [E]

vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$
```

L'empreinte de la clé doit correspondre à E8A0 32E0 94D8 EB4E A189 D270 DA41 8C88 A321 9F7B.

### Ajout du dépôt officiel Hashicorp

On utilise la commande:

```raw
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
```

La commande [**lsb_release -cs**] permet de retrouver le code projet de la version de linux utilisée.

Résultat:

```bash
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$ echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg]     https://apt.releases.hashicorp.com jammy main
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$
```

On peut maintenant récupérer les informations des paquets logiciels présents sur le dépôt HashiCorp.

On utilise la commande:

```raw
sudo apt update
```

Résultat:

```raw
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$ sudo apt update
Hit:1 https://download.docker.com/linux/ubuntu jammy InRelease
Hit:2 http://security.ubuntu.com/ubuntu jammy-security InRelease
Hit:3 http://archive.ubuntu.com/ubuntu jammy InRelease
Hit:4 http://archive.ubuntu.com/ubuntu jammy-updates InRelease
Get:5 https://apt.releases.hashicorp.com jammy InRelease [12.0 kB]
Hit:6 http://archive.ubuntu.com/ubuntu jammy-backports InRelease
Hit:7 https://ppa.launchpadcontent.net/ansible/ansible/ubuntu jammy InRelease
Get:8 https://apt.releases.hashicorp.com jammy/main amd64 Packages [73.6 kB]
Fetched 85.6 kB in 1s (88.7 kB/s)
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
60 packages can be upgraded. Run 'apt list --upgradable' to see them.
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$
```

### Installation du paquet logiciel Terraform

On utilise la commande:

```raw
sudo apt-get install terraform
```

Résultat:

```raw
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$ sudo apt-get install terraform
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following NEW packages will be installed:
  terraform
0 upgraded, 1 newly installed, 0 to remove and 60 not upgraded.
Need to get 19.5 MB of archives.
After this operation, 61.3 MB of additional disk space will be used.
Get:1 https://apt.releases.hashicorp.com jammy/main amd64 terraform amd64 1.3.6 [19.5 MB]
Fetched 19.5 MB in 6s (3255 kB/s)
Selecting previously unselected package terraform.
(Reading database ... 113807 files and directories currently installed.)
Preparing to unpack .../terraform_1.3.6_amd64.deb ...
Unpacking terraform (1.3.6) ...
Setting up terraform (1.3.6) ...
Scanning processes...
Scanning candidates...
Scanning linux images...

Running kernel seems to be up-to-date.

Restarting services...
 systemctl restart networkd-dispatcher.service unattended-upgrades.service

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$
```

### Vérification de l'installation de Terraform

On utilise la commande:

```raw
terraform -help
```

Résultat:

```raw
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$ terraform -help
Usage: terraform [global options] <subcommand> [args]

The available commands for execution are listed below.
The primary workflow commands are given first, followed by
less common or more advanced commands.

Main commands:
  init          Prepare your working directory for other commands
  validate      Check whether the configuration is valid
  plan          Show changes required by the current configuration
  apply         Create or update infrastructure
  destroy       Destroy previously-created infrastructure

All other commands:
  console       Try Terraform expressions at an interactive command prompt
  fmt           Reformat your configuration in the standard style
  force-unlock  Release a stuck lock on the current workspace
  get           Install or upgrade remote Terraform modules
  graph         Generate a Graphviz graph of the steps in an operation
  import        Associate existing infrastructure with a Terraform resource
  login         Obtain and save credentials for a remote host
  logout        Remove locally-stored credentials for a remote host
  output        Show output values from your root module
  providers     Show the providers required for this configuration
  refresh       Update the state to match remote systems
  show          Show the current state or a saved plan
  state         Advanced state management
  taint         Mark a resource instance as not fully functional
  test          Experimental support for module integration testing
  untaint       Remove the 'tainted' state from a resource instance
  version       Show the current Terraform version
  workspace     Workspace management

Global options (use these before the subcommand, if any):
  -chdir=DIR    Switch to a different working directory before executing the
                given subcommand.
  -help         Show this help output, or the help for a specified subcommand.
  -version      An alias for the "version" subcommand.
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$
```

### Activation de l'autocomplétion pour Terraform

Il faut vérifier que l'on dispose bien du fichier de configuration de notre shell Bash.

```bash
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$ ls -la ~/.bashrc
-rw-r--r-- 1 vagrant vagrant 3771 Jun  9  2022 /home/vagrant/.bashrc
```

Si ce n'est pas le cas on peut le créer avec la commande suivante pour le shell Bash.

```bash
touch ~/.bashrc
```

Il ne reste plus qu'à installer la prise en charge de l'autocomplétien pour Terraform.

On utilise la commande:

```raw
terraform -install-autocomplete
```

Résultat:

```bash
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$ terraform -install-autocomplete
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$
```

On constate l'ajout d'une ligne supplémentaire dans le fichier de configuration de notre bash après l'installation.

```bash
vagrant@ubuntu-jammy:~$ grep terraform ~/.bashrc
complete -C /usr/bin/terraform terraform
```

Il est nécessaire de redémarrer son shell pour bien prendre en compte l'installation.

## Tutoriel d'utilisation de Terraform

### Création du répertoire de travail

```bash
vagrant@ubuntu-jammy:~$ cd /vagrant/build-docker-with-terraform/

vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$ mkdir learn-terraform-docker-container

vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform$ cd learn-terraform-docker-container/
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform/learn-terraform-docker-container$
```

### Création du fichier main.tf

On crée le fichier [main.tf] avec la configuration suivante:

```terraform
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}
```

Le projet crée un conteneur docker et provisionne une image nginx:latest tout en exposant le port Interne(docker-guest) 80 sur le port Externe(vm-host) 8000.

### Initialisation du projet Terraform

A partir du répertoire où se trouve le fichier [main.tf], on initialise le projet terraform avec la commande suivante:

```raw
terraform init
```

Résultat:

```raw
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform/learn-terraform-docker-container$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding kreuzwerker/docker versions matching "~> 2.13.0"...
- Installing kreuzwerker/docker v2.13.0...
- Installed kreuzwerker/docker v2.13.0 (self-signed, key ID 24E54F214569A8A5)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform/learn-terraform-docker-container$
```

La commande lors de l'initialisation installe le plugin qui pilote docker pour le déploiement de notre conteneur docker nginx.

### Vérification des ressources à déployer

On utilise la commande:

```raw
sudo terraform plan
```

Résultat:

```raw
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform/learn-terraform-docker-container$ sudo terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # docker_container.nginx will be created
  + resource "docker_container" "nginx" {
      + attach           = false
      + bridge           = (known after apply)
      + command          = (known after apply)
      + container_logs   = (known after apply)
      + entrypoint       = (known after apply)
      + env              = (known after apply)
      + exit_code        = (known after apply)
      + gateway          = (known after apply)
      + hostname         = (known after apply)
      + id               = (known after apply)
      + image            = (known after apply)
      + init             = (known after apply)
      + ip_address       = (known after apply)
      + ip_prefix_length = (known after apply)
      + ipc_mode         = (known after apply)
      + log_driver       = "json-file"
      + logs             = false
      + must_run         = true
      + name             = "tutorial"
      + network_data     = (known after apply)
      + read_only        = false
      + remove_volumes   = true
      + restart          = "no"
      + rm               = false
      + security_opts    = (known after apply)
      + shm_size         = (known after apply)
      + start            = true
      + stdin_open       = false
      + tty              = false

      + healthcheck {
          + interval     = (known after apply)
          + retries      = (known after apply)
          + start_period = (known after apply)
          + test         = (known after apply)
          + timeout      = (known after apply)
        }

      + labels {
          + label = (known after apply)
          + value = (known after apply)
        }

      + ports {
          + external = 8000
          + internal = 80
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }

  # docker_image.nginx will be created
  + resource "docker_image" "nginx" {
      + id           = (known after apply)
      + keep_locally = false
      + latest       = (known after apply)
      + name         = "nginx:latest"
      + output       = (known after apply)
      + repo_digest  = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.
╷
│ Warning: Deprecated attribute
│
│   on main.tf line 18, in resource "docker_container" "nginx":
│   18:   image = docker_image.nginx.latest
│
│ The attribute "latest" is deprecated. Refer to the provider documentation for details.
│
│ (and one more similar warning elsewhere)
╵

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform/learn-terraform-docker-container$
```

### Déploiement du conteneur docker nginx

On utilise la commande:

```raw
sudo terraform apply
```

Résultat:

```raw
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform/learn-terraform-docker-container$ sudo terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # docker_container.nginx will be created
  + resource "docker_container" "nginx" {
      + attach           = false
      + bridge           = (known after apply)
      + command          = (known after apply)
      + container_logs   = (known after apply)
      + entrypoint       = (known after apply)
      + env              = (known after apply)
      + exit_code        = (known after apply)
      + gateway          = (known after apply)
      + hostname         = (known after apply)
      + id               = (known after apply)
      + image            = (known after apply)
      + init             = (known after apply)
      + ip_address       = (known after apply)
      + ip_prefix_length = (known after apply)
      + ipc_mode         = (known after apply)
      + log_driver       = "json-file"
      + logs             = false
      + must_run         = true
      + name             = "tutorial"
      + network_data     = (known after apply)
      + read_only        = false
      + remove_volumes   = true
      + restart          = "no"
      + rm               = false
      + security_opts    = (known after apply)
      + shm_size         = (known after apply)
      + start            = true
      + stdin_open       = false
      + tty              = false

      + healthcheck {
          + interval     = (known after apply)
          + retries      = (known after apply)
          + start_period = (known after apply)
          + test         = (known after apply)
          + timeout      = (known after apply)
        }

      + labels {
          + label = (known after apply)
          + value = (known after apply)
        }

      + ports {
          + external = 8000
          + internal = 80
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }

  # docker_image.nginx will be created
  + resource "docker_image" "nginx" {
      + id           = (known after apply)
      + keep_locally = false
      + latest       = (known after apply)
      + name         = "nginx:latest"
      + output       = (known after apply)
      + repo_digest  = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.
╷
│ Warning: Deprecated attribute
│
│   on main.tf line 18, in resource "docker_container" "nginx":
│   18:   image = docker_image.nginx.latest
│
│ The attribute "latest" is deprecated. Refer to the provider documentation for details.
│
│ (and one more similar warning elsewhere)
╵

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

docker_image.nginx: Creating...
docker_image.nginx: Still creating... [10s elapsed]
docker_image.nginx: Still creating... [20s elapsed]
docker_image.nginx: Creation complete after 28s [id=sha256:ac8efec875ce36b619cb41f91d9db579487b9d45ed29393dc957a745b1e0024fnginx:latest]
docker_container.nginx: Creating...
docker_container.nginx: Creation complete after 1s [id=683938dcb903e70ce5100b3540b808b45566803287677bdde676dddc3c69fa6e]
╷
│ Warning: Deprecated attribute
│
│   on main.tf line 18, in resource "docker_container" "nginx":
│   18:   image = docker_image.nginx.latest
│
│ The attribute "latest" is deprecated. Refer to the provider documentation for details.
│
│ (and one more similar warning elsewhere)
╵

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform/learn-terraform-docker-container$
```

### Validation du déploiement

On utilise la commande:

```raw
curl localhost:8000
```

Résultat:

```raw
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform/learn-terraform-docker-container$ curl localhost:8000
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform/learn-terraform-docker-container$
```

### Destruction du déploiement

Une fois que l'on a terminée, on peut supprimer les ressources provisionnées qui ne sont plus nécessaires. On utilise la commande:

```raw
sudo terraform destroy
```

Résultats:

```raw
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform/learn-terraform-docker-container$ sudo terraform destroy
docker_image.nginx: Refreshing state... [id=sha256:ac8efec875ce36b619cb41f91d9db579487b9d45ed29393dc957a745b1e0024fnginx:latest]
docker_container.nginx: Refreshing state... [id=683938dcb903e70ce5100b3540b808b45566803287677bdde676dddc3c69fa6e]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # docker_container.nginx will be destroyed
  - resource "docker_container" "nginx" {
      - attach            = false -> null
      - command           = [
          - "nginx",
          - "-g",
          - "daemon off;",
        ] -> null
      - cpu_shares        = 0 -> null
      - dns               = [] -> null
      - dns_opts          = [] -> null
      - dns_search        = [] -> null
      - entrypoint        = [
          - "/docker-entrypoint.sh",
        ] -> null
      - env               = [] -> null
      - gateway           = "172.17.0.1" -> null
      - group_add         = [] -> null
      - hostname          = "683938dcb903" -> null
      - id                = "683938dcb903e70ce5100b3540b808b45566803287677bdde676dddc3c69fa6e" -> null
      - image             = "sha256:ac8efec875ce36b619cb41f91d9db579487b9d45ed29393dc957a745b1e0024f" -> null
      - init              = false -> null
      - ip_address        = "172.17.0.3" -> null
      - ip_prefix_length  = 16 -> null
      - ipc_mode          = "private" -> null
      - links             = [] -> null
      - log_driver        = "json-file" -> null
      - log_opts          = {} -> null
      - logs              = false -> null
      - max_retry_count   = 0 -> null
      - memory            = 0 -> null
      - memory_swap       = 0 -> null
      - must_run          = true -> null
      - name              = "tutorial" -> null
      - network_data      = [
          - {
              - gateway                   = "172.17.0.1"
              - global_ipv6_address       = ""
              - global_ipv6_prefix_length = 0
              - ip_address                = "172.17.0.3"
              - ip_prefix_length          = 16
              - ipv6_gateway              = ""
              - network_name              = "bridge"
            },
        ] -> null
      - network_mode      = "default" -> null
      - privileged        = false -> null
      - publish_all_ports = false -> null
      - read_only         = false -> null
      - remove_volumes    = true -> null
      - restart           = "no" -> null
      - rm                = false -> null
      - security_opts     = [] -> null
      - shm_size          = 64 -> null
      - start             = true -> null
      - stdin_open        = false -> null
      - sysctls           = {} -> null
      - tmpfs             = {} -> null
      - tty               = false -> null

      - ports {
          - external = 8000 -> null
          - internal = 80 -> null
          - ip       = "0.0.0.0" -> null
          - protocol = "tcp" -> null
        }
    }

  # docker_image.nginx will be destroyed
  - resource "docker_image" "nginx" {
      - id           = "sha256:ac8efec875ce36b619cb41f91d9db579487b9d45ed29393dc957a745b1e0024fnginx:latest" -> null
      - keep_locally = false -> null
      - latest       = "sha256:ac8efec875ce36b619cb41f91d9db579487b9d45ed29393dc957a745b1e0024f" -> null
      - name         = "nginx:latest" -> null
      - repo_digest  = "nginx@sha256:ab589a3c466e347b1c0573be23356676df90cd7ce2dbf6ec332a5f0a8b5e59db" -> null
    }

Plan: 0 to add, 0 to change, 2 to destroy.
╷
│ Warning: Deprecated attribute
│
│   on main.tf line 18, in resource "docker_container" "nginx":
│   18:   image = docker_image.nginx.latest
│
│ The attribute "latest" is deprecated. Refer to the provider documentation for details.
╵

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

docker_container.nginx: Destroying... [id=683938dcb903e70ce5100b3540b808b45566803287677bdde676dddc3c69fa6e]
docker_container.nginx: Destruction complete after 0s
docker_image.nginx: Destroying... [id=sha256:ac8efec875ce36b619cb41f91d9db579487b9d45ed29393dc957a745b1e0024fnginx:latest]
docker_image.nginx: Destruction complete after 0s

Destroy complete! Resources: 2 destroyed.
vagrant@ubuntu-jammy:/vagrant/build-docker-with-terraform/learn-terraform-docker-container$
```

## Déploiement FastAPI avec Terraform

Je me base sur les documentations suivantes:

- <https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image>
- <https://fastapi.tiangolo.com/deployment/docker/#build-a-docker-image-for-fastapi>
