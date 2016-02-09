# hybrid
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: liberia.narrhy.compare.Rout 

##################################################################

# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md
include stuff.mk
include $(ms)/perl.def

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

## Do a hybrid fit DEPRECATED ... read separately from fitting
## Also, BROKEN

# hidden in hybrid.mk

##################################################################

data/liberia.cc.csv: $(gitroot)/WA_Ebola_Outbreak/liberia150429.npc.Rout.csv
	$(ln)

liberia.data.Rout: data/liberia.cc.csv data.R
	$(run-R)

liberia.hybrid.Rout: hybrid.R
%.hybrid.Rout: %.data.Rout %.hybrid.params.Rout hybrid.params.Rout hybrid5.autobug hybrid.R
	$(run-R)

%.narrhy.Rout: %.data.Rout %.hybrid.params.Rout hybrid.params.Rout narrow.params.Rout hybrid5.autobug hybrid.R
	$(run-R)

## Get estimates from posterior chains

liberia.hybrid.est.Rout: est.R
.PRECIOUS: %.est.Rout
%.est.Rout: %.Rout est.R
	$(run-R)

##################################################################

### Make projections and compare with reality

liberia.narrhy.compare.Rout: compare.R

%.compare.Rout: %.est.Rout forecastPlot.Rout compare.R
	$(run-R)

%.data.Rout: data/%.cc.csv data.R
	$(run-R)

##################################################################




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

# .PRECIOUS: %.R %.pl %.bugtmp
# %.R %.pl %.bugtmp:
	# /bin/cp -f $(crib)/$@ .

