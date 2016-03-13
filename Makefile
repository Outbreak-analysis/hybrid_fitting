# hybrid
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: sierraLeone.longh.compare.Rout.pdf

##################################################################

# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md
include stuff.mk
-include $(ms)/perl.def

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

data/liberia.cc.csv: $(gitroot)/WA_Ebola_Outbreak/liberia.npc.Rout.csv
	$(lnf)

data/guinea.cc.csv: $(gitroot)/WA_Ebola_Outbreak/guinea.npc.Rout.csv
	$(lnf)

data/sierraLeone.cc.csv: $(gitroot)/WA_Ebola_Outbreak/sierraLeone.npc.Rout.csv
	$(lnf)


sierraLeone.data.Rout: sierraLeone.cc.csv data.R
		       $(run-R)
#%.data.Rout: data/%.cc.csv data.R
#	$(run-R)

%.hybrid.Rout: %.data.Rout %.hybrid.params.Rout hybrid.params.Rout hybrid5.autobug hybrid.R
	$(run-R)

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

%.data.Rout: data/%.cc.csv data.R
	$(run-R)

##################################################################

-include $(ms)/git.mk
-include $(ms)/visual.mk

-include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
