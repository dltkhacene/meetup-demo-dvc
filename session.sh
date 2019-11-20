#doitlive commentecho: true
# Scenario:
# ---------
# A new dataset popped up, we have done the necessary data exploration phase,
# We found that this problem could be solved using machine learning techniques,
# Thus, we have annotated the dataset, and we're ready to start working on it.
# ===================================================================================
tree -L 3 -a
tree imagenet_mini/train/class1 | tail -1
tree imagenet_mini/train/class2 | tail -1
tree imagenet_mini/train/class3 | tail -1
tree imagenet_mini/train/class4 | tail -1
tree imagenet_mini/train/class5 | tail -1
tree imagenet_mini/train/class6 | tail -1
tree imagenet_mini/train/class_noise | tail -1
# -----------------------------------------------------------------------------------
# We have trained a on this dataset, the results were not satisfactory...
# -----------------------------------------------------------------------------------
# -----------------------------------------------------------------------------------
# First let's create an inital version of our dataset...
# -----------------------------------------------------------------------------------
git init
git add train.py .gitignore && git commit -m "Initial commit"
dvc init
tree -L 3 -a -h -I .git
git commit -m "Add DVC initialization"
tree imagenet_mini/train -L 1  
dvc add imagenet_mini
git add imagenet_mini.dvc && git commit -m "Add dataset_v0.1"
git tag dataset_v0.1
# -----------------------------------------------------------------------------------
# Our dataset contains noisy labels, we'll kick them out to try to increase accuracy
# -----------------------------------------------------------------------------------
rm -r imagenet_mini/train/class_noise
tree imagenet_mini/train -L 1
dvc status
dvc add imagenet_mini
git add imagenet_mini.dvc && git commit -m "Add dataset_v0.2: remove noisy data"
git tag dataset_v0.2
# -----------------------------------------------------------------------------------
# Now train a network with the version 0.2 of the dataset (clean version)
# -----------------------------------------------------------------------------------
# -----------------------------------------------------------------------------------
# We see that removing the noise didn't improve our training, we roll back to v0.1
# -----------------------------------------------------------------------------------
git checkout dataset_v0.1 imagenet_mini.dvc
dvc checkout
tree imagenet_mini/train -L 1
# -----------------------------------------------------------------------------------
# After a long meeting, we have decided that more data annotation is the key
# -----------------------------------------------------------------------------------
# -----------------------------------------------------------------------------------
# We have asked our annotation team to provide us with more annotated data...
# -----------------------------------------------------------------------------------
cp --verbose ../class6/images/* imagenet_mini/train/class6/images/
tree imagenet_mini/train/class6 | tail -1
dvc status
dvc add imagenet_mini
git add imagenet_mini.dvc && git commit -m "Add datasaet_v0.3: Add additional annotatations for class6."
# -----------------------------------------------------------------------------------
# The dataset is now saved, and can be restored out of DVC cache. 
# (YOU HAVE TO BELIEVE ME)
# -----------------------------------------------------------------------------------
rm -r imagenet_mini
dvc checkout
tree -L 3 -a -h -I .git
tree imagenet_mini/train/class6 | tail -1
rm -rf .git .dvc .vscode imagenet_mini.dvc "imagenet_mini/train/class6/images/new*"
