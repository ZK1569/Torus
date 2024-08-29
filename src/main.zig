const std = @import("std");

pub fn main() !void {
    const theta_spacing: f16 = 0.07;
    const phi_spacing: f16 = 0.02;

    const r1 = 1;
    const r2 = 2;
    const k2 = 5;
    const k1: u32 = 50 * k2 * 3 / (8 * (r1 + r2)); // 50 == screen_width

    var A: f64 = 5.0;
    var B: f64 = 5.0;

    while (true) {
        const cosA = @cos(A);
        const sinA = @sin(A);
        const cosB = @cos(B);
        const sinB = @sin(B);

        A += 0.0007;
        B += 0.0003;

        var output: [50][50]u8 = undefined;
        for (&output) |*row| {
            row.* = [_]u8{' '} ** 50;
        }
        const zbuffer = std.mem.zeroes([50][50]u8);

        const end: f64 = 2 * std.math.pi;
        var theta: f64 = 0.0;
        while (theta < end) : (theta += theta_spacing) {
            const cos_theta: f64 = @cos(theta);
            const sin_theta: f64 = @sin(theta);

            // std.debug.print("theta : {}, cos(theta): {}, sin(theta): {}\n", .{ theta, cos_theta, sin_theta });

            var phi: f64 = 0.0;
            while (phi < 2 * std.math.pi) : (phi += phi_spacing) {
                const cos_phi: f64 = @cos(phi);
                const sin_phi: f64 = @sin(phi);

                const circlex = r2 + r1 * cos_theta;
                const circley = r1 * sin_theta;

                const x = circlex * (cosB * cos_phi + sinA * sinB * sin_phi) - circley * cosA * sinB;
                const y = circlex * (sinB * cos_phi - sinA * cosB * sin_phi) + circley * cosA * cosB;
                const ooz: f64 = 1 / (k2 + cosA * circlex * sin_phi + sinA * circley);

                const xp: u64 = @intFromFloat(50 / 2 + k1 * ooz * x);
                const yp: u64 = @intFromFloat(50 / 2 - k1 * ooz * y);

                const L = cos_phi * cos_theta * sinB - cosA * cos_theta * sin_phi - sinA * sin_theta + cosB * (cosA * sin_theta - cos_theta * sinA * sin_phi);

                if (L > 0) {
                    // FIX: Convert ooz f64 into u8
                    // const ooz_value: u8 = @intFromFloat(ooz);
                    const ooz_value: u8 = 2;
                    if (ooz_value > zbuffer[xp][yp]) {
                        const luminance_index = L * 8;
                        const index: usize = @intFromFloat(luminance_index);
                        output[xp][yp] = ".,-~:;=!*#$@"[index];
                    }
                }
            }
        }

        std.debug.print("\x1b[H", .{});
        for (0..50) |j| {
            for (0..50) |i| {
                std.debug.print("{c}", .{output[i][j]});
            }
            std.debug.print("\n", .{});
        }
    }
}
