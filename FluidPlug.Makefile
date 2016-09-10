#!/usr/bin/make -f
# Makefile for FluidPlug #
# ---------------------- #
# Created by falkTX
#

include Makefile.mk

DESTDIR =/home/pi/zynthian/zynthian-plugins


# ---------------------------------------------------------------------------------------------------------------------

all: build

clean:
	rm -f *.lv2/*.so exporter

distclean: clean
	rm -f *.lv2/README
	rm -f *.lv2/*.sf2
	rm -f *.lv2/*.tar
	rm -f *.lv2/*.tar.7z

install: \
	install-AirFont320 \
	install-FluidGM \
	install-FluidBass \
	install-FluidBrass \
	install-FluidChromPerc \
	install-FluidDrums \
	install-FluidEnsemble \
	install-FluidEthnic \
	install-FluidGuitars \
	install-FluidOrgans \
	install-FluidPercussion \
	install-FluidPianos \
	install-FluidPipes \
	install-FluidReeds \
	install-FluidSoundFX \
	install-FluidStrings \
	install-FluidSynthFX \
	install-FluidSynthLeads \
	install-FluidSynthPads

install-AirFont320: AirFont320
	install -d $(DESTDIR)/mod-lv2/AirFont320.lv2
	install -m 644 \
		AirFont320.lv2/*.so \
		AirFont320.lv2/*.ttl \
		$(DESTDIR)/mod-lv2/AirFont320.lv2
	mv AirFont320.lv2/*.sf2 $(DESTDIR)/mod-lv2/AirFont320.lv2
	cp -r AirFont320.lv2/modgui      $(DESTDIR)/mod-lv2/AirFont320.lv2

install-FluidGM: FluidGM
	install -d $(DESTDIR)/mod-lv2/FluidGM.lv2
	install -m 644 \
		FluidGM.lv2/*.so \
		FluidGM.lv2/*.ttl \
		$(DESTDIR)/mod-lv2/FluidGM.lv2
	mv FluidGM.lv2/*.sf2 $(DESTDIR)/mod-lv2/FluidGM.lv2
	install -d $(DESTDIR)/mod-lv2/FluidGM.lv2
	cp -r FluidGM.lv2/modgui         $(DESTDIR)/mod-lv2/FluidGM.lv2

install-FluidBass: FluidBass
	install -d $(DESTDIR)/mod-lv2/FluidBass.lv2
	install -m 644 \
		FluidBass.lv2/*.so \
		FluidBass.lv2/*.ttl \
		$(DESTDIR)/mod-lv2/FluidBass.lv2
	mv FluidBass.lv2/*.sf2 $(DESTDIR)/mod-lv2/FluidBass.lv2
	install -d $(DESTDIR)/mod-lv2/FluidBass.lv2
	cp -r FluidBass.lv2/modgui       $(DESTDIR)/mod-lv2/FluidBass.lv2

install-FluidBrass: FluidBrass
	install -d $(DESTDIR)/mod-lv2/FluidBrass.lv2
	install -m 644 \
		FluidBrass.lv2/*.so \
		FluidBrass.lv2/*.ttl \
		$(DESTDIR)/mod-lv2/FluidBrass.lv2
	mv FluidBrass.lv2/*.sf2 $(DESTDIR)/mod-lv2/FluidBrass.lv2
	install -d $(DESTDIR)/mod-lv2/FluidBrass.lv2
	cp -r FluidBrass.lv2/modgui      $(DESTDIR)/mod-lv2/FluidBrass.lv2

install-FluidChromPerc: FluidChromPerc
	install -d $(DESTDIR)/mod-lv2/FluidChromPerc.lv2
	install -m 644 \
		FluidChromPerc.lv2/*.so \
		FluidChromPerc.lv2/*.ttl \
		$(DESTDIR)/mod-lv2/FluidChromPerc.lv2
	mv FluidChromPerc.lv2/*.sf2 $(DESTDIR)/mod-lv2/FluidChromPerc.lv2
	install -d $(DESTDIR)/mod-lv2/FluidChromPerc.lv2
	cp -r FluidChromPerc.lv2/modgui  $(DESTDIR)/mod-lv2/FluidChromPerc.lv2

install-FluidDrums: FluidDrums
	install -d $(DESTDIR)/mod-lv2/FluidDrums.lv2
	install -m 644 \
		FluidDrums.lv2/*.so \
		FluidDrums.lv2/*.ttl \
		$(DESTDIR)/mod-lv2/FluidDrums.lv2
	mv FluidDrums.lv2/*.sf2 $(DESTDIR)/mod-lv2/FluidDrums.lv2
	install -d $(DESTDIR)/mod-lv2/FluidDrums.lv2
	cp -r FluidDrums.lv2/modgui      $(DESTDIR)/mod-lv2/FluidDrums.lv2

install-FluidEnsemble: FluidEnsemble
	install -d $(DESTDIR)/mod-lv2/FluidEnsemble.lv2
	install -m 644 \
		FluidEnsemble.lv2/*.so \
		FluidEnsemble.lv2/*.ttl \
		$(DESTDIR)/mod-lv2/FluidEnsemble.lv2
	mv FluidEnsemble.lv2/*.sf2 $(DESTDIR)/mod-lv2/FluidEnsemble.lv2
	install -d $(DESTDIR)/mod-lv2/FluidEnsemble.lv2
	cp -r FluidEnsemble.lv2/modgui   $(DESTDIR)/mod-lv2/FluidEnsemble.lv2

install-FluidEthnic: FluidEthnic
	install -d $(DESTDIR)/mod-lv2/FluidEthnic.lv2
	install -m 644 \
		FluidEthnic.lv2/*.so \
		FluidEthnic.lv2/*.ttl \
		$(DESTDIR)/mod-lv2/FluidEthnic.lv2
	mv FluidEthnic.lv2/*.sf2 $(DESTDIR)/mod-lv2/FluidEthnic.lv2
	install -d $(DESTDIR)/mod-lv2/FluidEthnic.lv2
	cp -r FluidEthnic.lv2/modgui     $(DESTDIR)/mod-lv2/FluidEthnic.lv2

install-FluidGuitars: FluidGuitars
	install -d $(DESTDIR)/mod-lv2/FluidGuitars.lv2
	install -m 644 \
		FluidGuitars.lv2/*.so \
		FluidGuitars.lv2/*.ttl \
		$(DESTDIR)/mod-lv2/FluidGuitars.lv2
	mv FluidGuitars.lv2/*.sf2 $(DESTDIR)/mod-lv2/FluidGuitars.lv2
	install -d $(DESTDIR)/mod-lv2/FluidGuitars.lv2
	cp -r FluidGuitars.lv2/modgui    $(DESTDIR)/mod-lv2/FluidGuitars.lv2

install-FluidOrgans: FluidOrgans
	install -d $(DESTDIR)/mod-lv2/FluidOrgans.lv2
	install -m 644 \
		FluidOrgans.lv2/*.so \
		FluidOrgans.lv2/*.ttl \
		$(DESTDIR)/mod-lv2/FluidOrgans.lv2
	mv FluidOrgans.lv2/*.sf2 $(DESTDIR)/mod-lv2/FluidOrgans.lv2
	install -d $(DESTDIR)/mod-lv2/FluidOrgans.lv2
	cp -r FluidOrgans.lv2/modgui     $(DESTDIR)/mod-lv2/FluidOrgans.lv2

install-FluidPercussion: FluidPercussion
	install -d $(DESTDIR)/mod-lv2/FluidPercussion.lv2
	install -m 644 \
		FluidPercussion.lv2/*.so \
		FluidPercussion.lv2/*.ttl \
		$(DESTDIR)/mod-lv2/FluidPercussion.lv2
	mv FluidPercussion.lv2/*.sf2 $(DESTDIR)/mod-lv2/FluidPercussion.lv2
	install -d $(DESTDIR)/mod-lv2/FluidPercussion.lv2
	cp -r FluidPercussion.lv2/modgui $(DESTDIR)/mod-lv2/FluidPercussion.lv2

install-FluidPianos: FluidPianos
	install -d $(DESTDIR)/mod-lv2/FluidPianos.lv2
	install -m 644 \
		FluidPianos.lv2/*.so \
		FluidPianos.lv2/*.ttl \
		$(DESTDIR)/mod-lv2/FluidPianos.lv2
	mv FluidPianos.lv2/*.sf2 $(DESTDIR)/mod-lv2/FluidPianos.lv2
	install -d $(DESTDIR)/mod-lv2/FluidPianos.lv2
	cp -r FluidPianos.lv2/modgui     $(DESTDIR)/mod-lv2/FluidPianos.lv2

install-FluidPipes: FluidPipes
	install -d $(DESTDIR)/mod-lv2/FluidPipes.lv2
	install -m 644 \
		FluidPipes.lv2/*.so \
		FluidPipes.lv2/*.ttl \
		$(DESTDIR)/mod-lv2/FluidPipes.lv2
	mv FluidPipes.lv2/*.sf2 $(DESTDIR)/mod-lv2/FluidPipes.lv2
	install -d $(DESTDIR)/mod-lv2/FluidPipes.lv2
	cp -r FluidPipes.lv2/modgui      $(DESTDIR)/mod-lv2/FluidPipes.lv2

install-FluidReeds: FluidReeds
	install -d $(DESTDIR)/mod-lv2/FluidReeds.lv2
	install -m 644 \
		FluidReeds.lv2/*.so \
		FluidReeds.lv2/*.ttl \
		$(DESTDIR)/mod-lv2/FluidReeds.lv2
	mv FluidReeds.lv2/*.sf2 $(DESTDIR)/mod-lv2/FluidReeds.lv2
	install -d $(DESTDIR)/mod-lv2/FluidReeds.lv2
	cp -r FluidReeds.lv2/modgui      $(DESTDIR)/mod-lv2/FluidReeds.lv2

install-FluidSoundFX: FluidSoundFX
	install -d $(DESTDIR)/mod-lv2/FluidSoundFX.lv2
	install -m 644 \
		FluidSoundFX.lv2/*.so \
		FluidSoundFX.lv2/*.ttl \
		$(DESTDIR)/mod-lv2/FluidSoundFX.lv2
	mv FluidSoundFX.lv2/*.sf2 $(DESTDIR)/mod-lv2/FluidSoundFX.lv2
	install -d $(DESTDIR)/mod-lv2/FluidSoundFX.lv2
	cp -r FluidSoundFX.lv2/modgui    $(DESTDIR)/mod-lv2/FluidSoundFX.lv2

install-FluidStrings: FluidStrings
	install -d $(DESTDIR)/mod-lv2/FluidStrings.lv2
	install -m 644 \
		FluidStrings.lv2/*.so \
		FluidStrings.lv2/*.ttl \
		$(DESTDIR)/mod-lv2/FluidStrings.lv2
	mv FluidStrings.lv2/*.sf2 $(DESTDIR)/mod-lv2/FluidStrings.lv2
	install -d $(DESTDIR)/mod-lv2/FluidStrings.lv2
	cp -r FluidStrings.lv2/modgui    $(DESTDIR)/mod-lv2/FluidStrings.lv2

install-FluidSynthFX: FluidSynthFX
	install -d $(DESTDIR)/mod-lv2/FluidSynthFX.lv2
	install -m 644 \
		FluidSynthFX.lv2/*.so \
		FluidSynthFX.lv2/*.ttl \
		$(DESTDIR)/mod-lv2/FluidSynthFX.lv2
	mv FluidSynthFX.lv2/*.sf2 $(DESTDIR)/mod-lv2/FluidSynthFX.lv2
	install -d $(DESTDIR)/mod-lv2/FluidSynthFX.lv2
	cp -r FluidSynthFX.lv2/modgui    $(DESTDIR)/mod-lv2/FluidSynthFX.lv2

install-FluidSynthLeads: FluidSynthLeads
	install -d $(DESTDIR)/mod-lv2/FluidSynthLeads.lv2
	install -m 644 \
		FluidSynthLeads.lv2/*.so \
		FluidSynthLeads.lv2/*.ttl \
		$(DESTDIR)/mod-lv2/FluidSynthLeads.lv2
	mv FluidSynthLeads.lv2/*.sf2 $(DESTDIR)/mod-lv2/FluidSynthLeads.lv2
	install -d $(DESTDIR)/mod-lv2/FluidSynthLeads.lv2
	cp -r FluidSynthLeads.lv2/modgui $(DESTDIR)/mod-lv2/FluidSynthLeads.lv2

install-FluidSynthPads: FluidSynthPads
	install -d $(DESTDIR)/mod-lv2/FluidSynthPads.lv2
	install -m 644 \
		FluidSynthPads.lv2/*.so \
		FluidSynthPads.lv2/*.ttl \
		$(DESTDIR)/mod-lv2/FluidSynthPads.lv2
	mv FluidSynthPads.lv2/*.sf2 $(DESTDIR)/mod-lv2/FluidSynthPads.lv2
	install -d $(DESTDIR)/mod-lv2/FluidSynthPads.lv2
	cp -r FluidSynthPads.lv2/modgui  $(DESTDIR)/mod-lv2/FluidSynthPads.lv2


# ---------------------------------------------------------------------------------------------------------------------

build: \
	install-AirFont320 \
	install-FluidGM \
	install-FluidBass \
	install-FluidBrass \
	install-FluidChromPerc \
	install-FluidDrums \
	install-FluidEnsemble \
	install-FluidEthnic \
	install-FluidGuitars \
	install-FluidOrgans \
	install-FluidPercussion \
	install-FluidPianos \
	install-FluidPipes \
	install-FluidReeds \
	install-FluidSoundFX \
	install-FluidStrings \
	install-FluidSynthFX \
	install-FluidSynthLeads \
	install-FluidSynthPads

# ---------------------------------------------------------------------------------------------------------------------

AirFont320: \
	AirFont320.lv2/FluidPlug.sf2 \
	AirFont320.lv2/FluidPlug.so \
	AirFont320.lv2/FluidPlug.ttl \
	AirFont320.lv2/manifest.ttl

FluidGM: \
	FluidGM.lv2/FluidPlug.sf2 \
	FluidGM.lv2/FluidPlug.so \
	FluidGM.lv2/FluidPlug.ttl \
	FluidGM.lv2/manifest.ttl

FluidBass: \
	FluidBass.lv2/FluidPlug.sf2 \
	FluidBass.lv2/FluidPlug.so \
	FluidBass.lv2/FluidPlug.ttl \
	FluidBass.lv2/manifest.ttl

FluidBrass: \
	FluidBrass.lv2/FluidPlug.sf2 \
	FluidBrass.lv2/FluidPlug.so \
	FluidBrass.lv2/FluidPlug.ttl \
	FluidBrass.lv2/manifest.ttl

FluidChromPerc: \
	FluidChromPerc.lv2/FluidPlug.sf2 \
	FluidChromPerc.lv2/FluidPlug.so \
	FluidChromPerc.lv2/FluidPlug.ttl \
	FluidChromPerc.lv2/manifest.ttl

FluidDrums: \
	FluidDrums.lv2/FluidPlug.sf2 \
	FluidDrums.lv2/FluidPlug.so \
	FluidDrums.lv2/FluidPlug.ttl \
	FluidDrums.lv2/manifest.ttl

FluidEnsemble: \
	FluidEnsemble.lv2/FluidPlug.sf2 \
	FluidEnsemble.lv2/FluidPlug.so \
	FluidEnsemble.lv2/FluidPlug.ttl \
	FluidEnsemble.lv2/manifest.ttl

FluidEthnic: \
	FluidEthnic.lv2/FluidPlug.sf2 \
	FluidEthnic.lv2/FluidPlug.so \
	FluidEthnic.lv2/FluidPlug.ttl \
	FluidEthnic.lv2/manifest.ttl

FluidGuitars: \
	FluidGuitars.lv2/FluidPlug.sf2 \
	FluidGuitars.lv2/FluidPlug.so \
	FluidGuitars.lv2/FluidPlug.ttl \
	FluidGuitars.lv2/manifest.ttl

FluidOrgans: \
	FluidOrgans.lv2/FluidPlug.sf2 \
	FluidOrgans.lv2/FluidPlug.so \
	FluidOrgans.lv2/FluidPlug.ttl \
	FluidOrgans.lv2/manifest.ttl

FluidPercussion: \
	FluidPercussion.lv2/FluidPlug.sf2 \
	FluidPercussion.lv2/FluidPlug.so \
	FluidPercussion.lv2/FluidPlug.ttl \
	FluidPercussion.lv2/manifest.ttl

FluidPianos: \
	FluidPianos.lv2/FluidPlug.sf2 \
	FluidPianos.lv2/FluidPlug.so \
	FluidPianos.lv2/FluidPlug.ttl \
	FluidPianos.lv2/manifest.ttl

FluidPipes: \
	FluidPipes.lv2/FluidPlug.sf2 \
	FluidPipes.lv2/FluidPlug.so \
	FluidPipes.lv2/FluidPlug.ttl \
	FluidPipes.lv2/manifest.ttl

FluidReeds: \
	FluidReeds.lv2/FluidPlug.sf2 \
	FluidReeds.lv2/FluidPlug.so \
	FluidReeds.lv2/FluidPlug.ttl \
	FluidReeds.lv2/manifest.ttl

FluidSoundFX: \
	FluidSoundFX.lv2/FluidPlug.sf2 \
	FluidSoundFX.lv2/FluidPlug.so \
	FluidSoundFX.lv2/FluidPlug.ttl \
	FluidSoundFX.lv2/manifest.ttl

FluidStrings: \
	FluidStrings.lv2/FluidPlug.sf2 \
	FluidStrings.lv2/FluidPlug.so \
	FluidStrings.lv2/FluidPlug.ttl \
	FluidStrings.lv2/manifest.ttl

FluidSynthFX: \
	FluidSynthFX.lv2/FluidPlug.sf2 \
	FluidSynthFX.lv2/FluidPlug.so \
	FluidSynthFX.lv2/FluidPlug.ttl \
	FluidSynthFX.lv2/manifest.ttl

FluidSynthLeads: \
	FluidSynthLeads.lv2/FluidPlug.sf2 \
	FluidSynthLeads.lv2/FluidPlug.so \
	FluidSynthLeads.lv2/FluidPlug.ttl \
	FluidSynthLeads.lv2/manifest.ttl

FluidSynthPads: \
	FluidSynthPads.lv2/FluidPlug.sf2 \
	FluidSynthPads.lv2/FluidPlug.so \
	FluidSynthPads.lv2/FluidPlug.ttl \
	FluidSynthPads.lv2/manifest.ttl

# ---------------------------------------------------------------------------------------------------------------------

AirFont320.lv2/FluidPlug.sf2:
	-@mkdir -p $(shell dirname $@)
	(cd AirFont320.lv2 && \
		wget http://download.linuxaudio.org/musical-instrument-libraries/sf2/airfont_a340u.tar.7z && \
		7z x airfont_a340u.tar.7z && \
		7z x airfont_a340u.tar && \
		mv airfont_a340u/* . && \
		mv airfont_a320u.sf2 FluidPlug.sf2 && \
		mv readme README && \
		rmdir airfont_a340u && \
		rm airfont_a340u.tar*)

FluidGM.lv2/FluidPlug.sf2:
	-@mkdir -p $(shell dirname $@)
	(cd FluidGM.lv2 && \
		wget http://download.linuxaudio.org/musical-instrument-libraries/sf2/fluidr3.tar.7z && \
		7z x fluidr3.tar.7z && \
		7z x fluidr3.tar && \
		mv fluidr3/* . && \
		mv fluidr3gm.sf2 FluidPlug.sf2 && \
		mv readme README && \
		rmdir fluidr3 && \
		rm fluidr3.tar*)

FluidBass.lv2/FluidPlug.sf2:
	-@mkdir -p $(shell dirname $@)
	(cd FluidBass.lv2 && \
		wget http://download.linuxaudio.org/musical-instrument-libraries/sf2/fluidr3-splitted/fluidr3gm_bass.sf2.tar.7z && \
		7z x fluidr3gm_bass.sf2.tar.7z && \
		7z x fluidr3gm_bass.sf2.tar && \
		mv fluidr3gm_bass.sf2 FluidPlug.sf2 && \
		rm fluidr3gm_bass.sf2.tar*)

FluidBrass.lv2/FluidPlug.sf2:
	-@mkdir -p $(shell dirname $@)
	(cd FluidBrass.lv2 && \
		wget http://download.linuxaudio.org/musical-instrument-libraries/sf2/fluidr3-splitted/fluidr3gm_brass.sf2.tar.7z && \
		7z x fluidr3gm_brass.sf2.tar.7z && \
		7z x fluidr3gm_brass.sf2.tar && \
		mv fluidr3gm_brass.sf2 FluidPlug.sf2 && \
		rm fluidr3gm_brass.sf2.tar*)

FluidChromPerc.lv2/FluidPlug.sf2:
	-@mkdir -p $(shell dirname $@)
	(cd FluidChromPerc.lv2 && \
		wget http://download.linuxaudio.org/musical-instrument-libraries/sf2/fluidr3-splitted/fluidr3gm_chromaticpercussion.sf2.tar.7z && \
		7z x fluidr3gm_chromaticpercussion.sf2.tar.7z && \
		7z x fluidr3gm_chromaticpercussion.sf2.tar && \
		mv fluidr3gm_chromaticpercussion.sf2 FluidPlug.sf2 && \
		rm fluidr3gm_chromaticpercussion.sf2.tar)

FluidDrums.lv2/FluidPlug.sf2:
	-@mkdir -p $(shell dirname $@)
	(cd FluidDrums.lv2 && \
		wget http://download.linuxaudio.org/musical-instrument-libraries/sf2/fluidr3-splitted/fluidr3gm_drums.sf2.tar.7z && \
		7z x fluidr3gm_drums.sf2.tar.7z && \
		7z x fluidr3gm_drums.sf2.tar && \
		mv fluidr3gm_drums.sf2 FluidPlug.sf2 && \
		rm fluidr3gm_drums.sf2.tar*)

FluidEnsemble.lv2/FluidPlug.sf2:
	-@mkdir -p $(shell dirname $@)
	(cd FluidEnsemble.lv2 && \
		wget http://download.linuxaudio.org/musical-instrument-libraries/sf2/fluidr3-splitted/fluidr3gm_ensemble.sf2.tar.7z && \
		7z x fluidr3gm_ensemble.sf2.tar.7z && \
		7z x fluidr3gm_ensemble.sf2.tar && \
		mv fluidr3gm_ensemble.sf2 FluidPlug.sf2 && \
		rm fluidr3gm_ensemble.sf2.tar*)

FluidEthnic.lv2/FluidPlug.sf2:
	-@mkdir -p $(shell dirname $@)
	(cd FluidEthnic.lv2 && \
		wget http://download.linuxaudio.org/musical-instrument-libraries/sf2/fluidr3-splitted/fluidr3gm_ethnic.sf2.tar.7z && \
		7z x fluidr3gm_ethnic.sf2.tar.7z && \
		7z x fluidr3gm_ethnic.sf2.tar && \
		mv fluidr3gm_ethnic.sf2 FluidPlug.sf2 && \
		rm fluidr3gm_ethnic.sf2.tar*)

FluidGuitars.lv2/FluidPlug.sf2:
	-@mkdir -p $(shell dirname $@)
	(cd FluidGuitars.lv2 && \
		wget http://download.linuxaudio.org/musical-instrument-libraries/sf2/fluidr3-splitted/fluidr3gm_guitar.sf2.tar.7z && \
		7z x fluidr3gm_guitar.sf2.tar.7z && \
		7z x fluidr3gm_guitar.sf2.tar && \
		mv fluidr3gm_guitar.sf2 FluidPlug.sf2 && \
		rm fluidr3gm_guitar.sf2.tar*)

FluidOrgans.lv2/FluidPlug.sf2:
	-@mkdir -p $(shell dirname $@)
	(cd FluidOrgans.lv2 && \
		wget http://download.linuxaudio.org/musical-instrument-libraries/sf2/fluidr3-splitted/fluidr3gm_organ.sf2.tar.7z && \
		7z x fluidr3gm_organ.sf2.tar.7z && \
		7z x fluidr3gm_organ.sf2.tar && \
		mv fluidr3gm_organ.sf2 FluidPlug.sf2 && \
		rm fluidr3gm_organ.sf2.tar*)

FluidPercussion.lv2/FluidPlug.sf2:
	-@mkdir -p $(shell dirname $@)
	(cd FluidPercussion.lv2 && \
		wget http://download.linuxaudio.org/musical-instrument-libraries/sf2/fluidr3-splitted/fluidr3gm_percussive.sf2.tar.7z && \
		7z x fluidr3gm_percussive.sf2.tar.7z && \
		7z x fluidr3gm_percussive.sf2.tar && \
		mv fluidr3gm_percussive.sf2 FluidPlug.sf2 && \
		rm fluidr3gm_percussive.sf2.tar*)

FluidPianos.lv2/FluidPlug.sf2:
	-@mkdir -p $(shell dirname $@)
	(cd FluidPianos.lv2 && \
		wget http://download.linuxaudio.org/musical-instrument-libraries/sf2/fluidr3-splitted/fluidr3gm_piano.sf2.tar.7z && \
		7z x fluidr3gm_piano.sf2.tar.7z && \
		7z x fluidr3gm_piano.sf2.tar && \
		mv fluidr3gm_piano.sf2 FluidPlug.sf2 && \
		rm fluidr3gm_piano.sf2.tar*)

FluidPipes.lv2/FluidPlug.sf2:
	-@mkdir -p $(shell dirname $@)
	(cd FluidPipes.lv2 && \
		wget http://download.linuxaudio.org/musical-instrument-libraries/sf2/fluidr3-splitted/fluidr3gm_pipe.sf2.tar.7z && \
		7z x fluidr3gm_pipe.sf2.tar.7z && \
		7z x fluidr3gm_pipe.sf2.tar && \
		mv fluidr3gm_pipe.sf2 FluidPlug.sf2 &&\
		rm fluidr3gm_pipe.sf2.tar*)

FluidReeds.lv2/FluidPlug.sf2:
	-@mkdir -p $(shell dirname $@)
	(cd FluidReeds.lv2 && \
		wget http://download.linuxaudio.org/musical-instrument-libraries/sf2/fluidr3-splitted/fluidr3gm_reed.sf2.tar.7z && \
		7z x fluidr3gm_reed.sf2.tar.7z && \
		7z x fluidr3gm_reed.sf2.tar && \
		mv fluidr3gm_reed.sf2 FluidPlug.sf2 && \
		rm fluidr3gm_reed.sf2.tar*)

FluidSoundFX.lv2/FluidPlug.sf2:
	-@mkdir -p $(shell dirname $@)
	(cd FluidSoundFX.lv2 && \
		wget http://download.linuxaudio.org/musical-instrument-libraries/sf2/fluidr3-splitted/fluidr3gm_soundeffects.sf2.tar.7z && \
		7z x fluidr3gm_soundeffects.sf2.tar.7z && \
		7z x fluidr3gm_soundeffects.sf2.tar && \
		mv fluidr3gm_soundeffects.sf2 FluidPlug.sf2 && \
		rm fluidr3gm_soundeffects.sf2.tar*)

FluidStrings.lv2/FluidPlug.sf2:
	-@mkdir -p $(shell dirname $@)
	(cd FluidStrings.lv2 && \
		wget http://download.linuxaudio.org/musical-instrument-libraries/sf2/fluidr3-splitted/fluidr3gm_strings.sf2.tar.7z && \
		7z x fluidr3gm_strings.sf2.tar.7z && \
		7z x fluidr3gm_strings.sf2.tar && \
		mv fluidr3gm_strings.sf2 FluidPlug.sf2 && \
		rm fluidr3gm_strings.sf2.tar*)

FluidSynthFX.lv2/FluidPlug.sf2:
	-@mkdir -p $(shell dirname $@)
	(cd FluidSynthFX.lv2 && \
		wget http://download.linuxaudio.org/musical-instrument-libraries/sf2/fluidr3-splitted/fluidr3gm_syntheffects.sf2.tar.7z && \
		7z x fluidr3gm_syntheffects.sf2.tar.7z && \
		7z x fluidr3gm_syntheffects.sf2.tar && \
		mv fluidr3gm_syntheffects.sf2 FluidPlug.sf2 && \
		rm fluidr3gm_syntheffects.sf2.tar*)

FluidSynthLeads.lv2/FluidPlug.sf2:
	-@mkdir -p $(shell dirname $@)
	(cd FluidSynthLeads.lv2 && \
		wget http://download.linuxaudio.org/musical-instrument-libraries/sf2/fluidr3-splitted/fluidr3gm_synthlead.sf2.tar.7z && \
		7z x fluidr3gm_synthlead.sf2.tar.7z && \
		7z x fluidr3gm_synthlead.sf2.tar && \
		mv fluidr3gm_synthlead.sf2 FluidPlug.sf2 && \
		rm fluidr3gm_synthlead.sf2.tar*)

FluidSynthPads.lv2/FluidPlug.sf2:
	-@mkdir -p $(shell dirname $@)
	(cd FluidSynthPads.lv2 && \
		wget http://download.linuxaudio.org/musical-instrument-libraries/sf2/fluidr3-splitted/fluidr3gm_synthpad.sf2.tar.7z && \
		7z x fluidr3gm_synthpad.sf2.tar.7z && \
		7z x fluidr3gm_synthpad.sf2.tar && \
		mv fluidr3gm_synthpad.sf2 FluidPlug.sf2 && \
		rm fluidr3gm_synthpad.sf2.tar*)

# ---------------------------------------------------------------------------------------------------------------------

%.lv2/FluidPlug.so: source/FluidPlug.c
	$(CC) $< -DFLUIDPLUG_LABEL=\"$*\" $(BUILD_C_FLAGS) $(FLUIDSYNTH_FLAGS) $(LINK_FLAGS) $(FLUIDSYNTH_LIBS) $(SHARED) -o $@

%.lv2/FluidPlug.ttl:
	sed "s/xLABELx/$*/" source/FluidPlug.ttl.p1 > $*.lv2/FluidPlug.ttl
	cd $*.lv2 && ../exporter >> FluidPlug.ttl
	sed "s/xLABELx/$*/" source/FluidPlug.ttl.p2 >> $*.lv2/FluidPlug.ttl

%.lv2/manifest.ttl:
	sed "s/xLABELx/$*/" source/manifest.ttl.in > $*.lv2/manifest.ttl

# ---------------------------------------------------------------------------------------------------------------------

exporter: source/Exporter.c
	$(CC) $< $(BUILD_C_FLAGS) $(FLUIDSYNTH_FLAGS) $(LINK_FLAGS) $(FLUIDSYNTH_LIBS) -o $@

# ---------------------------------------------------------------------------------------------------------------------
