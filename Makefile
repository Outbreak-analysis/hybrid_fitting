
## A probably-deprecated directory where I applied some of my hybrid stuff from the Ebola challenge to real Ebola data
## Still using at least for MMED slides

current: target
target = Makefile
-include target.mk
target: $(target)

##################################################################

sierraLeone.hybrid.compare.Rout-3.pdf:

# make files

Sources = Makefile .ignore README.md sub.mk LICENSE.md
include sub.mk
-include $(ms)/perl.def

Sources += makestuff/ WA_Ebola_Outbreak/

mdirs += WA_Ebola_Outbreak

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

liberia.cc.csv: WA_Ebola_Outbreak/liberia.npc.Rout.csv
	$(lnf)

guinea.cc.csv: WA_Ebola_Outbreak/guinea.npc.Rout.csv
	$(lnf)

sierraLeone.cc.csv: WA_Ebola_Outbreak/sierraLeone.npc.Rout.csv
	$(lnf)

sierraLeone.data.Rout: sierraLeone.cc.csv data.R
	$(run-R)

%.hybrid.Rout: %.data.Rout %.hybrid.params.Rout hybrid.params.Rout hybrid5.autobug hybrid.R
	$(run-R)

sierraLeone.hybridstan.Rout: sierraLeone.data.Rout sierraLeone.hybrid.params.Rout hybrid.params.Rout hybrid.stan hybridstan.R
	$(run-R)

#%.hybridstan.Rout: %.data.Rout %.hybrid.params.Rout hybrid.params.Rout hybrid.stan hybridstan.R
#		   $(run-R)

%.longh.Rout: %.data.Rout hybrid.params.Rout %.longh.params.Rout hybrid5.autobug hybrid.R
	$(run-R)

%.narrhy.Rout: %.data.Rout %.hybrid.params.Rout hybrid.params.Rout narrow.params.Rout hybrid5.autobug hybrid.R
	$(run-R)

## Get estimates from posterior chains

.PRECIOUS: %.est.Rout
%.est.Rout: %.Rout est.R
	$(run-R)

##################################################################

### Make projections and compare with reality

%.compare.Rout: %.est.Rout forecastPlot.Rout compare.R
	$(run-R)

%.data.Rout: %.cc.csv data.R
	$(run-R)

##################################################################

-include $(ms)/git.mk
-include $(ms)/visual.mk

-include $(ms)/wrapR.mk
-include $(ms)/modules.mk

# -include $(ms)/oldlatex.mk
