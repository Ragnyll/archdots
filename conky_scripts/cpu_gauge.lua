require 'cairo'

function conky_main()
    if conky_window == nil then
        return
    end
    local cs = cairo_xlib_surface_create (conky_window.display,
                                         conky_window.drawable,
                                         conky_window.visual,
                                         conky_window.width,
                                         conky_window.height)
    cr = cairo_create(cs)

	gauge_props = {
		gauge_name = "cpu",
		gauge_value = conky_parse("${cpu}"),
		gauge_max = 100,
		colors = {
			free_color = { -- dark_grey
				r = 35.9,
				g = 34.9,
				b = 36.9,
				a = .1
			},
			used_color = { -- light_grey
				r = 52.9,
				g = 51.3,
				b = 54.6,
				a = .4
			}
		},
		meter = {
			x = 200, -- the center x offset relative to conf bottom left
			y = 200, -- the center y offset relative to conf bottom left
			r = 50,  -- the radius of the guage
			w = 4    -- the width of the stroke
		}
	}

	-- draw the cpu_indicator
	cpu_indicator_gauge(cr, gauge_props)

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil
end

function cpu_indicator_gauge(cr, gauge_props)
	-- draws a ring indicator for cpu usage
	-- cr: cairo created surface
	-- gauge_props: table containing colors (free and used) and meter properties

	draw_free_ring(cr, gauge_props)
	draw_used_ring(cr, gauge_props)
end

function draw_free_ring(cr, ring_props)
	-- draws a dark gray ring
	-- cr: cairo created surface
	-- ring_props: table containing colors (free and used) and meter properties

	start_angle, end_angle = 0, (2 * math.pi)
	cairo_set_source_rgba(cr, ring_props.colors.free_color.r, ring_props.colors.free_color.g, ring_props.colors.free_color.b, ring_props.colors.free_color.a)
	cairo_set_line_width(cr, ring_props.meter.w)
	cairo_arc(cr, ring_props.meter.x, ring_props.meter.y, ring_props.meter.r, start_angle, end_angle)
	cairo_stroke(cr)
end

function draw_used_ring(cr, ring_props)
	-- draws a light circle indicating amount of resource used
	-- cr: cairo created surface
	-- ring_props: table containing colors (free and used) and meter properties

	-- move arc_indicator
	end_angle = ring_props.gauge_value * (360 / ring_props.gauge_max)

	-- Draw bg
	cairo_set_source_rgba(cr, ring_props.colors.used_color.r, ring_props.colors.used_color.g, ring_props.colors.used_color.b, ring_props.colors.used_color.a)
	cairo_set_line_width(cr, ring_props.meter.w)
	-- angles in cairo are drawn from pi (90 deg) they must be offset to start from top
	cairo_arc(cr, ring_props.meter.x, ring_props.meter.y, ring_props.meter.r, degrees_to_radians(-90), degrees_to_radians(end_angle - 90))
	cairo_stroke(cr)
end

function degrees_to_radians(degrees)
	return degrees * (math.pi / 180)
end
