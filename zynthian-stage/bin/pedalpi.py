#!/usr/bin/python3

from pluginsmanager.banks_manager import BanksManager
from pluginsmanager.observer.mod_host.mod_host import ModHost
from pluginsmanager.model.bank import Bank
from pluginsmanager.model.pedalboard import Pedalboard
from pluginsmanager.model.connection import Connection
from pluginsmanager.model.lv2.lv2_effect_builder import Lv2EffectBuilder
from pluginsmanager.model.system.system_effect import SystemEffect
from pluginsmanager.jack.jack_client import JackClient
from pluginsmanager.model.system.system_effect_builder import SystemEffectBuilder
from pluginsmanager.observer.autosaver.autosaver import Autosaver

client = JackClient()
#sys_effect = SystemEffectBuilder(client)
sys_effect = SystemEffect('system', [], ['playback_1', 'playback_2'])
modhost = SystemEffect('mod-host', ['midi_in'], [])

autosaver = Autosaver('/root/pedalpi')
manager=autosaver.load(sys_effect)

#manager = BanksManager()

# Mod-Host
mod_host = ModHost('localhost')
mod_host.connect()

manager.register(mod_host)

pedalboard = Pedalboard('MDA-EP')

builder = Lv2EffectBuilder()

ep = builder.build('http://moddevices.com/plugins/mda/EPiano')

pedalboard.connections.append(Connection(sys_effect.inputs[0], ep.outputs[0]))
pedalboard.connections.append(Connection(sys_effect.inputs[1], ep.outputs[1]))
pedalboard.connections.append(Connection(sys_effect.outputs[0], ep.inputs[0]))

# Safe close
from signal import pause
try:
    pause()
except KeyboardInterrupt:
    mod_host.close()
