To use:

(example)

```
cd environments/limnocentral
terraform plan
terraform apply

# (type 'yes')

```

To create a new environment:

```
cd environments
cp -r limnocentral howard-stage
rm howard-stage/{id_ed25519,id_ed25519.pub,kubeconfig-temp.yaml}
```

Those files should be unique for each environment. So you'll be creating another ssh key for the new cluster.

(Helpful tip: you can also use `flux create secret git` for this!)

Edit `main.tf`, update the `config_path` for `provider "flux"` in `main.tf`,
and update the bootstrap path for Flux to be unique for the new cluster.

Once you have a new ssh key and kubeconfig, set up the deploy key for read-write, and run:

```
cd howard-stage
terraform plan
terraform apply
```
