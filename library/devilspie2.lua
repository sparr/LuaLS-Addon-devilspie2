---@meta

---Documentation originally from https://github.com/dsalt/devilspie2/blob/760df8ce0db8f51c75acbb27ab0e420174cb8352/README



---A 1-based index into the list of monitors.
---
---`0` refers to the "current" monitor based on the window's centre point,
---falling back on the first monitor showing part of the window, then the first monitor
---
---`-1` refers to all monitors treated as a single large virtual monitor
---
---Values greater than the number of monitors fall back to the first monitor
---@alias MonitorIndex -1 | 0 | integer

---The name of a workspace or the 1-based index into the list of workspaces.
---@alias WorkspaceIdentifier number | string

---@alias WindowTypeShort
---| "WINDOW_TYPE_NORMAL"
---| "WINDOW_TYPE_DESKTOP"
---| "WINDOW_TYPE_DOCK"
---| "WINDOW_TYPE_DIALOG"
---| "WINDOW_TYPE_TOOLBAR"
---| "WINDOW_TYPE_MENU"
---| "WINDOW_TYPE_UTILITY"
---| "WINDOW_TYPE_SPLASHSCREEN"

---@alias WindowTypeLong
---| "_NET_WM_WINDOW_TYPE_NORMAL"
---| "_NET_WM_WINDOW_TYPE_DESKTOP"
---| "_NET_WM_WINDOW_TYPE_DOCK"
---| "_NET_WM_WINDOW_TYPE_DIALOG"
---| "_NET_WM_WINDOW_TYPE_TOOLBAR"
---| "_NET_WM_WINDOW_TYPE_MENU"
---| "_NET_WM_WINDOW_TYPE_UTILITY"
---| "_NET_WM_WINDOW_TYPE_SPLASHSCREEN"

---@alias WindowType WindowTypeShort | WindowTypeLong

---@alias WindowTypeException "WINDOW_TYPE_UNRECOGNIZED" | "WINDOW_ERROR"

---Window property values can be one of many types.
---
---The types specified here are understood by devilspie2, but there
---are other types that are not currently supported, such as arrays.
---@alias WindowPropertyValue string | number | boolean



---Print a string to stdout iff devilspie2 was run with the --debug option.
---@param string string
function debug_print (string) end



---Allow for situations where moving or resizing the window is done
---incorrectly.
---
---e.g. `set_window_position(0,0)` results in the window decoration being
---taken into account twice, i.e. the window (including decoration) is offset
---from the top left corner by the width of the left side decoration and the
---height of the title bar.
---
---This is currently off by default, and is sticky: if you do not explicitly
---set it in your script, its current value is retained.
---
---If used, it should be used at the start of the script.
---
---This affects the following functions:
---@see set_window_geometry
---@see set_window_position
---@see set_window_size
---@see xy
---@see xywh
---
---(available from version 0.45)
---@param adjust boolean? default true
function set_adjust_for_decoration (adjust) end



---Get the name of the window.
---@return string name
function get_window_name () end

---Get whether the window has a name or not.
---
---(from version 0.20)
---@return boolean has_name
function get_window_has_name () end

---Set the position of the window.
---
---If index is specified then the co-ordinates are relative to a corner of
---the specified monitor (counting from 1) on the current workspace. Which
---corner is determined by the co-ordinates' signs:
---```
---   +ve X ⇒ left, -ve X ⇒ right;
---   +ve Y ⇒ top,  -ve Y ⇒ bottom.
---```
---NOTE: since `-0` would have a use here but is equal to `+0`, `~` (bitwise
---NOT) is used. To put the window 60px from the right or bottom, use `~60`
---or `-61`.
---
---If `index == 0` then the ‘current’ monitor (with the window's centre point)
---is used (falling back on then the first monitor showing part of the
---window then the first monitor).
---
---If `index == -1` then all monitors are treated as one large virtual monitor.
---@see set_window_position2
---@param x integer
---@param y integer
---@param index MonitorIndex?
---@return boolean? success
function set_window_position (x, y, index) end

---Set the position of the window.
---
---Compared to `set_window_position`, this function uses `XMoveWindow` instead
---of `wnck_window_set_geometry` which gives a slightly different result.
---
---(available from version 0.21)
---@see set_window_position
---@param x integer
---@param y integer
function set_window_position2 (x, y) end

---Set the size of the window.
---@param width integer
---@param height integer
function set_window_size (width, height) end

---Set the reserved area at the borders of the desktop for a docking area such
---as a taskbar or a panel.
---
---Default minimum values are 0 and default maximum values are taken from the
---screen size (current or maximum, depending on whether xrandr is used).
---
---Parameters as from `_NET_WM_STRUT_PARTIAL`
---
---(available from version 0.32)
---@param left integer
---@param right integer
---@param top integer
---@param bottom integer
---@param left_start_y integer?
---@param left_end_y integer?
---@param right_start_y integer?
---@param right_end_y integer?
---@param top_start_x integer?
---@param top_end_x integer?
---@param bottom_start_x integer?
---@param bottom_end_x integer?
function set_window_strut (left, right, top, bottom,
    left_start_y, left_end_y,right_start_y, right_end_y,
    top_start_x, top_end_x, bottom_start_x, bottom_end_x) end

---Set size and position of the window.
---@see set_window_geometry2
---@param x integer
---@param y integer
---@param width integer
---@param height integer
function set_window_geometry (x, y, width, height) end

---Set the window geometry just as set_window_geometry, using
---`XMoveResizeWindow` instead of its `libwnck` alternative.
---
---This results in different coordinates than the `set_window_geometry`
---function, and results are more similar to the results of the original
---devilspie `geometry` function.
---
---(available from version 0.21)
---@see set_window_geometry
---@param x integer
---@param y integer
---@param width integer
---@param height integer
function set_window_geometry2 (x, y, width, height) end

---Get the application name of the window.
---@return string application_name
function get_application_name () end

---Shade the window, showing only the title-bar.
function shade () end

---Unshade the window, the opposite of `shade`.
function unshade () end

---Maximise the window.
---
---(-ise from 0.45)
function maximize () end
maximise = maximize

---Maximise the window horizontally.
---
---(-ise from 0.45)
function maximize_horizontally () end
maximise_horizontally = maximize_horizontally
maximize_horisontally = maximize_horizontally -- deprecated

---Maximise the window vertically.
---
---(-ise from 0.45)
function maximize_vertically () end
maximise_vertically = maximize_vertically

---Unmaximise the window.
---
---(-ise from 0.45)
function unmaximize () end
unmaximise = unmaximize

---Minimise the window.
---
---(-ise from 0.45)
function minimize () end
minimise = minimize

---Unminimise the window.
---
---(-ise from 0.45)
function unminimize () end
unminimise = unminimize

---Show all decorations for the window.
---@return boolean success?
function decorate_window () end

---Remove all decorations from the window.
---@return boolean success?
function undecorate_window () end

---Move the window to another workspace.
---@param workspace WorkspaceIdentifier name or 1-based index
---@return boolean success?
function set_window_workspace (workspace) end

---Change the current active workspace.
---@param workspace WorkspaceIdentifier name or 1-based index
---@return boolean success?
function change_workspace (workspace) end

---Get the number of workspaces available.
---
---(available from version 0.27)
---@return integer workspace_count
function get_workspace_count () end

---Ask the window manager to put the window on all workspaces.
---@see unpin_window
function pin_window () end

---Ask the window manager to put window only on the currently active workspace
---iff it was pinned.
---@see pin_window
function unpin_window () end

---Ask the window manager to keep the window's position fixed on the screen,
---even when the workspace or viewport scrolls.
---@see unstick_window
function stick_window () end

---Ask the window manager to not have the window's position fixed on the screen
---when the workspace or viewport scrolls.
---@see stick_window
function unstick_window () end

---Close the window.
---
---(available from 0.31)
function close_window () end

---Get the window geometry.
---
---(from version 0.16)
---@return integer x, integer y, integer width, integer height
function get_window_geometry () end

---Get the window geometry excluding the window manager borders.
---@return integer x, integer y, integer width, integer height
function get_window_client_geometry () end

---Get the window frame extents.
---
---(from version 0.45)
---@return integer left, integer right, integer top, integer bottom
function get_window_frame_extents () end

---Set the window to skip or not skip listing in your tasklist.
---
---(from version 0.16)
---@param skip boolean Whether to skip listing this window in your task list
function set_skip_tasklist (skip) end

---Set the window to skip or not skip listing in your pager.
---
---(from version 0.16)
---@param skip boolean Whether to skip listing this window in your pager
function set_skip_pager (skip) end

---Get whether the window is maximised.
---
---(available from version 0.21; -ise from 0.45)
---@return boolean is_maximized
function get_window_is_maximized () end
get_window_is_maximised = get_window_is_maximized

---Get whether the window is vertically maximised.
---
---(available from version 0.21; -ise from 0.45)
---@return boolean is_maximized_vertically
function get_window_is_maximized_vertically () end
get_window_is_maximised_vertically = get_window_is_maximized_vertically

---Get whether the window is horizontally maximised.
---
---(available from version 0.21; -ise from 0.45)
---@return boolean is_maximized_horizontally
function get_window_is_maximized_horizontally () end
get_window_is_maximised_horizontally = get_window_is_maximized_horizontally
get_window_is_maximized_horisontally = get_window_is_maximized_horizontally

---Get whether the window is pinned.
---@return boolean is_pinned
function get_window_is_pinned () end

---Get whether the window is decorated.
---
---(available from version 0.44)
---@return boolean is_decorated
function get_window_is_decorated () end

---Set the window below all normal windows, or unsets that behavior.
---
---(available from version 0.21)
---@param below boolean? Set (`true`, default) or unset (`false`) the always-on-bottom behavior
function set_window_below (below) end

---Set the window above all normal windows, or unsets that behavior.
---
---(available from version 0.21)
---@see make_always_on_top is the same as `set_window_above(true)`.
---@param above boolean? Set (`true`, default) or unset (`false`) the always-on-top behavior
function set_window_above (above) end

---Ask the window manager to set the fullscreen state of the window.
---
---(available from version 0.24)
---@param fullscreen boolean Set (`true`) or unset (`false`) the fullscreen state
function set_window_fullscreen (fullscreen) end

---Set the window above all normal windows.
---
---(available from version 0.21)
---
---The same as `set_window_above(true)`.
---@see set_window_above
function make_always_on_top () end

---Set the window on top of all others.
---
---Unlike `set_window_above`, it doesn't lock the window in this position.
---
---As of version 0.45, the window's layer (above, between, below) is
---maintained.
function set_on_top () end

---Set the window below all others.
---
---Unlike set_window_below, it doesn't lock the window in this position.
---
---As of version 0.45, the window's layer (above, between, below) is
---maintained.
function set_on_bottom () end

---Get the type of the window.
---
---Or `WINDOW_TYPE_UNRECOGNIZED` if libwnck didn't recognise the type.
---
---Or `WINDOW_ERROR` if the function for some reason didn't have the window to
---work on
---
---(available from version 0.21)
---@return WindowTypeShort | WindowTypeException type
function get_window_type () end

---Get the value of a window property.
---
---For a list of available properties, you should see the page
---https://specifications.freedesktop.org/wm-spec/latest/
---
---From 0.45, returns nil if the property doesn't exist.
---
---(available from version 0.21)
---@param property string name of the property
---@return string? value property value converted to a string
function get_window_property (property) end

---Get the window role of the window.
---@return string role as defined by the `WM_WINDOW_ROLE` hint.
function get_window_role () end

---Get the X window id of the window.
---@return integer xid
function get_window_xid () end

---Get the class of the window.
---@return string class
function get_window_class () end

---Set a property of the window.
---
---(available from version 0.44)
---@param property string name of the property
---@param value WindowPropertyValue
function set_window_property (property, value) end

---Remove a property from the window.
---
---(available from version 0.44)
---@param property string name of the property
function delete_window_property (property) end

---Move the window to the requested viewport
---
---(available from version 0.25)
---
---OR
---
---Move the window to a specific location within the viewport
---
---(available from version 0.40)
---@param viewport integer 1-based viewport index
---@overload fun(x: integer, y: integer)
function set_viewport (viewport) end

---Centre the window.
---
---With no parameters, centres the window on the current workspace.
---May place the window across multiple monitors.
---
---If `index` is specified, centres the window on the specified
---monitor on the current workspace.
---
---If `direction` begins with 'H' or 'h', the window is horizontally centred only.
---
---If `direction` begins with 'V' or 'v', the window is vertically centred only.
---
---If centring only along one axis, the window may be moved along the other
---axis to ensure that it is on the specified monitor.
---
---(Available without parameters from version 0.26)
---
---(Parameters and ‘centre’ available from version 0.44)
---@param index MonitorIndex? default `-1` (all monitors)
---@param direction string? Starts with "h" or "v", default `""` (both axes)
function center (index, direction) end
centre = center

---Set the window opacity.
---
---(available from version 0.28, set_window_opacity from 0.29)
---@param opacity number `1.0` is completely opaque, `0.0` is completely see-through
function set_window_opacity (opacity) end
set_opacity = set_window_opacity

---Set the window type.
---
---(available from version 0.28)
---@param type WindowType
function set_window_type (type) end

---Get the screen geometry for the screen of the window
---
---(available from version 0.29)
---@return integer width, integer height
function get_screen_geometry () end

---Get whether the window is fullscreen.
---
---(available from version 0.32)
---@return boolean is_fullscreen
function get_window_fullscreen () end
get_fullscreen = get_window_fullscreen

---Get the reserved area at the borders of the desktop for a docking
---area such as a taskbar or a panel.
---
---Get a table (12 integers as for `_NET_WM_STRUT_PARTIAL`) or
---nil. If `_NET_WM_WINDOW_STRUT` was read then defaults are used as for
---set_window_strut().
---
---(Available from version 0.45)
---@return integer[]?
function get_window_strut () end

---Get the class instance name for the window.
---
---Only available on libwnck 3+
---
---(available from version 0.21)
---@return string class_instance_name from the `WM_CLASS` property
function get_class_instance_name () end

---Get the class group name for the window.
---
---Only available on libwnck 3+
---
---(available from version 0.45)
---@return string class_group_name from the `WM_CLASS` property
function get_class_group_name () end

---Focus the window.
---
---(available from version 0.30)
function focus () end
focus_window = focus

---Get the index of the monitor containing the window centre (or some
---part of the window).
---
---(available from version 0.44)
---@return integer monitor_index
function get_monitor_index () end

---Get the geometry of a monitor.
---
---(available from version 0.44)
---@param index integer? monitor index (default is the window's monitor)
---@return integer x, integer y, integer width, integer height
function get_monitor_geometry (index) end

---Set or get the position of the window
---
---Sets the position if given parameters, otherwise returns the current position.
---@param x integer
---@param y integer
---@overload fun(): integer, integer
function xy (x, y) end

---Set or get the position and size of the window.
---
---Sets the position and size if given parameters,
---otherwise returns the current position and size.
---@return integer x, integer y, integer width, integer height
---@overload fun(x: integer, y: integer, width: integer, height: integer)
function xywh () end

---Register a function to be called when the window's geometry changes in the
---future.
---@param callback fun()
function on_geometry_changed (callback) end

---Get the name of the process owning the window.
---
---On (at least) Linux, the process name is read from `/proc/<pid>/comm`. If
---that's not possible, 'ps' is launched in a shell. For this reason, you
---should avoid calling `get_process_name()` more than necessary.
---
---This function is not compatible with busybox `ps`.
---
---(Available from version 0.44)
---@return string process_name
function get_process_name () end



---If there is a file named devilspie2.lua in config folder, it is read and
---it is searched for the global variables linked below.
---
---The filenames in the strings in these tables will be called when windows are
---closed, focused, blurred, or have a name change, respectively. If these
---variables isn't present in this file, it will be called as a devilspie2
---script file like any other.
---
---For example:
---```lua
---scripts_window_close = {
---   "file1.lua",
---   "file2.lua"
---}
---```
---This would make the files `file1.lua` and `file2.lua` interpreted when windows are
---closing instead of when windows are opening.
---@see scripts_window_close
---@see scripts_window_focus
---@see scripts_window_blur
---@see scripts_window_name_change
---@alias CallbackScripts string[]

---@type CallbackScripts
scripts_window_close = {}

---@type CallbackScripts
scripts_window_focus = {}

---@type CallbackScripts
scripts_window_blur = {}

---@type CallbackScripts
scripts_window_name_change = {}
