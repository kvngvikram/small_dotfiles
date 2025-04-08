#!/usr/bin/python3
# Note: use system python3, not /usr/bin/env, because whichever python3 is on
# $PATH may not have dbus, but the system python3 does.

"""Toggle display scaling between 100% and 200%.

Based on https://gist.github.com/strycore/ca11203fd63cafcac76d4b04235d8759

For data structure definitions, see
https://gitlab.gnome.org/GNOME/mutter/blob/master/src/org.gnome.Mutter.DisplayConfig.xml
"""

import dbus

namespace = "org.gnome.Mutter.DisplayConfig"
dbus_path = "/org/gnome/Mutter/DisplayConfig"

session_bus = dbus.SessionBus()
obj = session_bus.get_object(namespace, dbus_path)
interface = dbus.Interface(obj, dbus_interface=namespace)

current_state = interface.GetCurrentState()
serial = current_state[0]
connected_monitors = current_state[1]
logical_monitors = current_state[2]

# Multiple monitors are more complicated. For now, since I only use one monitor
# in Ubuntu, everything is hard-coded so that only info about the first monitor
# is used, and only it will be connected after running the script.
#
# If someday updating this script: a logical monitor may appear on mutiple
# connected monitors due to mirroring.
connector = connected_monitors[0][0][0]
# current_mode = None
# # ApplyMonitorsConfig() needs (connector name, mode ID) for each connected
# # monitor of a logical monitor, but GetCurrentState() only returns the
# # connector name for each connected monitor of a logical monitor. So iterate
# # through the globally connected monitors to find the mode ID.
# for mode in connected_monitors[0][1]:
#     if mode[6].get("is-current", False):
#         current_mode = mode[0]
# updated_connected_monitors = [[connector, current_mode, {}]]

mode = dbus.String('1920x1080@60')
updated_connected_monitors = [[connector, mode, {}]]

x, y, scale, transform, primary, monitors, props = logical_monitors[0]
# scale = 2.0 if scale == 1.0 else 1.0
scale = 1.0

monitor_config = [[x, y, scale, transform, primary, updated_connected_monitors]]
print(monitor_config)

# Change the 1 to a 2 if you want a "Revert Settings / Keep Changes" dialog
interface.ApplyMonitorsConfig(serial, 1, monitor_config, {})
