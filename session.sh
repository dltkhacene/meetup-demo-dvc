#doitlive commentecho: true
git init
git add train.py .gitignore
git commit -m "Initial commit"
dvc init
git commit -m "Add DVC initialization"
tree imagenet_mini/train -L 1
dvc add imagenet_mini
git add imagenet_mini.dvc
git commit -m "Add dataset_v0.1"
git tag dataset_v0.1
rm -r imagenet_mini/train/class_noise
tree imagenet_mini/train -L 1
dvc status
dvc add imagenet_mini
git add imagenet_mini.dvc
git commit -m "Add dataset_v0.2"
# Now we start a training with the version 0.2 of the dataset
# We see that removing the noise didn't improve our training, we roll back to v0.1
git checkout dataset_v0.1 imagenet_mini.dvc
dvc checkout
tree imagenet_mini/train -L 1
rm -rf .git .dvc .vscode imagenet_mini.dvc
