# wiritttes

Branch|[![Travis CI logo](TravisCI.png)](https://travis-ci.org)|[![Codecov logo](Codecov.png)](https://www.codecov.io)
---|---|---
master|[![Build Status](https://travis-ci.org/richelbilderbeek/wiritttes.svg?branch=master)](https://travis-ci.org/richelbilderbeek/wiritttes)|[![codecov.io](https://codecov.io/github/richelbilderbeek/wiritttes/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/wiritttes/branch/master)
develop|[![Build Status](https://travis-ci.org/richelbilderbeek/wiritttes.svg?branch=develop)](https://travis-ci.org/richelbilderbeek/wiritttes)|[![codecov.io](https://codecov.io/github/richelbilderbeek/wiritttes/coverage.svg?branch=develop)](https://codecov.io/github/richelbilderbeek/wiritttes/branch/develop)

What If Reproductive Isolation Takes Time To Establish Simulations.

## Installing `wiritttes`

The `wiritttes` package is absent on CRAN.

An easy way is to install it from GitHub. Within R, do:

```
devtools::install_github("richelbilderbeek/wiritttes")
```

## Using `wiritttes` as a package dependency

If your package uses `wiritttes`, add the following to the `DESCRIPTION` its `Remotes` section:

```
Remotes:
  richelbilderbeek/wiritttes
```

## Update the package source on Peregrine

```
module load git; git pull
```

## Copy all files from Peregrine to local computer

```
scp p230198@peregrine.hpc.rug.nl:/home/p230198/GitHubs/wiritttes/scripts/*.* ~/Peregrine
```

## Workflow

On Peregrine, from the `wiritttes` root folder:

```
cd scripts
./run.sh
```

This will create a dataset consisting of `.RDa` files.
Each `RDa` will contain the paramaters of a run, 
its incipient species tree, sampled species trees, 
alignments and its posteriors.

These files can be analysed
by the `wiritttea` package.

## How to create the test examples?

 * Run the function `do_test_simulations`

## How to install

To install this repository, you will need to:

 * Clone this repository
 * Install packages
 * Install BEAST2

Steps are shown below.

### Clone this repository

From the GNU/Linux terminal, or using Windows Git Bash:

```
git clone https://github.com/richelbilderbeek/wiritttes
```

This will create a folder called `wiritttes`. 

You may also need to do this, for GNU/Linux:

```
sudo apt-get install libcurl4-openssl-dev
```

### Install packages

You will need some packages, which are listed in `install_r_packages.R`.

In Linux, you can install all of these with:

```
sudo install_r_packages.sh
```

### Install BEAST2

You will need to install BEAST2. 

You can do this from [the BEAST2 GitHub](https://github.com/CompEvol/beast2).

In Linux, you can install it with:

```
./install_beast2.sh
```

## Article

The article-in-preparation can be found
at the closed [wirittte_article GitHub](https://github.com/richelbilderbeek/wirittte_article)

## Resources

 * [My 2015-11-23 TRES presentation](https://github.com/richelbilderbeek/Science/blob/master/Bilderbeek20151123TresMeeting/20151123TresMeeting.pdf)
 * [My 2016-02-03 TECE presentation](https://github.com/richelbilderbeek/Science/blob/master/Bilderbeek20160203TeceMeeting/20160203TeceMeeting.pdf)
 * [My 2016 TRES presentation about BEAST2](https://github.com/richelbilderbeek/Science/blob/master/Bilderbeek2016Beast/Bilderbeek2016Beast.pdf)
 * [My R repository](https://github.com/richelbilderbeek/R), especially the `Phylogeny` and `Peregrine` folders may be of help
 * [Prolonging the Past Counteracts the Pull of the Present: Protracted Speciation Can Explain Observed Slowdowns in Diversification. Rampal S. Etienne, James Rosindell. 2012](http://sysbio.oxfordjournals.org/content/61/2/204)
 * Nee, Sean, Robert M. May, and Paul H. Harvey. "The reconstructed evolutionary process." Philosophical Transactions of the Royal Society of London B: Biological Sciences 344.1309 (1994): 305-311.
 * [R coding standard](https://github.com/richelbilderbeek/R-CodingStandard)
 * [Pro Git](https://git-scm.com/book/en/v2)
 * Tidy Data, Hadley Wickham
 * R packages, Hadley Wickham
 * Advanced R, Hadley Wickham
