To use:

## Run

(example)

```
cd environments/limnocentral
terraform plan
terraform apply

# (type 'yes')

```

To create a new environment:

## Copy

Copy from the existing environment to create a new home for staging deployments (for example):

```
cd environments
cp -r limnocentral howard-stage
rm howard-stage/{id_ed25519,id_ed25519.pub,kubeconfig-temp.yaml,terraform.tfstate*,.terraform.lock.hcl}
```

Those removed files should be unique for each environment. So you'll be creating another ssh key for the new cluster:

```
$ ssh-keygen -t ed25519
Generating public/private ed25519 key pair.
Enter file in which to save the key (/Users/kingdonb/.ssh/id_ed25519): ./id_ed25519
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in ./id_ed25519
Your public key has been saved in ./id_ed25519.pub
The key fingerprint is:
SHA256:LLAZxhjeJA9Em3pkqYRXRawzePvW9Dqpk4f7zOAY/pU kingdonb@kingdon-mbp.turkey.local
The key's randomart image is:
+--[ED25519 256]--+
| o* o+o          |
|.. #  .          |
|..X.B.           |
|.*..== .         |
|o ..o+. S        |
| .  .  ...       |
|    ...=Eo       |
|   . +*== .      |
|    oo=*=o       |
+----[SHA256]-----+
```

(Helpful tip: you can also use `flux create secret git` for this!)

### Local kube.config file

Copy your CAPI (or admin) kubeconfig file to `kubeconfig-temp.yaml` in the environment.

I am using vcluster, so to populate the credential, I connect to the management cluster and run:

```bash
vcluster connect howard-moomboo-staging -n vcluster-howard-moomboo-stage \
  --server https://howard.moomboo.stage --kube-config ./kubeconfig-temp.yaml \
  --update-current=false
```

Edit `main.tf`: update the `config_path` for `provider "flux"` in `main.tf` to
point at the new `kubeconfig-temp.yaml`, wherever you are keeping it.

Then, update the bootstrap `path` for Flux to be the new target for bootstrap
content in the git repository for the staging cluster.

## Run Again

Now, let's bootstrap the target cluster.

Once you have a new ssh key and kubeconfig, set up the deploy key for read-write, and run:

```
cd howard-stage
terraform plan
terraform apply
```

Now that Flux is bootstrapped on the cluster, use it for everything!

## Clean Up

Delete the temporary Kube credential, and enjoy using GitOps from now on.
Since we can upgrade Flux via PR, we won't need to run Terraform again.
