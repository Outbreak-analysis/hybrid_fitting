# hybrid
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: T2.NIH2.hybrid.Rout 

##################################################################

# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md
include stuff.mk
# include $(ms)/perl.def

##################################################################

# Discussion

Sources += todo.md notes.md

######################################################################

# Files to put in github

Sources += $(wildcard *.R)
Sources += $(wildcard *.pl)
Sources += $(wildcard *.bugtmp)

######################################################################

## Making bug files from templates

.PRECIOUS: hybrid%.autobug
hybrid%.autobug: hybrid.bugtmp lagchain.pl
	$(RM) $@
	$(PUSHSTAR)
	$(READONLY)

##################################################################

## Do a hybrid fit

T2.NIH2.hybrid.Rout: hybrid.bugtmp hybrid.R

%.hybrid.Rout: hybrid.params.Rout data/%.cc.csv hybrid5.autobug hybrid.R
	$(run-R)

### Makestuff

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

-include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk

##################################################################

# Cribbing!!!!!!

crib = $(gitroot)/Latent_incidence_fitting

.PRECIOUS: %.R %.pl %.bugtmp
%.R %.pl %.bugtmp:
	/bin/cp -f $(crib)/$@ .

