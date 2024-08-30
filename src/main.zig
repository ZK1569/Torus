const std = @import("std");

const screen_width: u16 = 50;
const screen_height: u16 = 50;

pub fn main() !void {
    const theta_spacing: f16 = 0.07;
    const phi_spacing: f16 = 0.02;

    const r1 = 1;
    const r2 = 2;
    const k2 = 5;
    const k1: u32 = screen_width * k2 * 3 / (8 * (r1 + r2));

    var A: f64 = 1.0;
    var B: f64 = 1.0;

    while (true) {
        const cosA = @cos(A);
        const sinA = @sin(A);
        const cosB = @cos(B);
        const sinB = @sin(B);

        A += 0.007;
        B += 0.003;

        var output: [screen_width][screen_height]u8 = undefined;
        for (&output) |*row| {
            row.* = [_]u8{' '} ** screen_height;
        }
        const zbuffer = std.mem.zeroes([screen_width][screen_height]u8);

        const end: f64 = 2 * std.math.pi;
        var theta: f64 = 0.0;
        while (theta < end) : (theta += theta_spacing) {
            const cos_theta: f64 = @cos(theta);
            const sin_theta: f64 = @sin(theta);

            var phi: f64 = 0.0;
            while (phi < 2 * std.math.pi) : (phi += phi_spacing) {
                const cos_phi: f64 = @cos(phi);
                const sin_phi: f64 = @sin(phi);

                const circlex = r2 + r1 * cos_theta;
                const circley = r1 * sin_theta;

                const x = circlex * (cosB * cos_phi + sinA * sinB * sin_phi) - circley * cosA * sinB;
                const y = circlex * (sinB * cos_phi - sinA * cosB * sin_phi) + circley * cosA * cosB;
                const ooz: f64 = 1 / (k2 + cosA * circlex * sin_phi + sinA * circley);

                const xp: u64 = @intFromFloat(screen_width / 2 + k1 * ooz * x);
                const yp: u64 = @intFromFloat(screen_height / 2 - k1 * ooz * y);

                const L = cos_phi * cos_theta * sinB - cosA * cos_theta * sin_phi - sinA * sin_theta + cosB * (cosA * sin_theta - cos_theta * sinA * sin_phi);

                if (L > 0) {
                    const ooz_value: i8 = @intFromFloat(ooz * 255);
                    if (ooz_value > zbuffer[xp][yp]) {
                        const luminance_index = L * 8;
                        const index: usize = @intFromFloat(luminance_index);
                        output[xp][yp] = ".,-~:;=!*#$@"[index];
                    }
                }
            }
        }

        std.debug.print("\x1b[H", .{});
        for (0..screen_height) |j| {
            for (0..screen_width) |i| {
                std.debug.print("{c}{c}", .{ output[i][j], output[i][j] });
            }
            std.debug.print("\n", .{});
        }
    }
}
