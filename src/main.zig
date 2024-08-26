const std = @import("std");

pub fn main() !void {
    const theta_spacing: f16 = 0.07;
    const phi_spacing: f16 = 0.02;

    const r1 = 1;
    const r2 = 2;
    const k2 = 5;
    const k1: u32 = 150 * k2 * 3 / (8 * (r1 + r2)); // 150 == screen_width

    // INFO: Must be var
    const A: f64 = 1;
    const B: f64 = 1;

    // TODO: Add a while loop
    const cosA = @cos(A);
    const sinA = @sin(A);
    const cosB = @cos(B);
    const sinB = @cos(B);

    const output = std.mem.zeroes([150][150]u8);
    var zbuffer: [150][150]u8 = undefined;
    for (&zbuffer) |*row| {
        row.* = [_]u8{'_'} ** 150;
    }

    const end: f64 = 2 * std.math.pi;
    var theta: f64 = 0.0;
    while (theta < end) : (theta += theta_spacing) {
        const cos_theta: f64 = @cos(theta);
        const sin_theta: f64 = @sin(theta);

        std.debug.print("theta : {}, cos(theta): {}, sin(theta): {}\n", .{ theta, cos_theta, sin_theta });

        var phi: f64 = 0.0;
        while (phi < 2 * std.math.pi) : (phi += 0.1) {}
    }

    // TODO: Things to delete
    _ = output;
    _ = phi_spacing;
    _ = k1;
    _ = cosA;
    _ = cosB;
    _ = sinA;
    _ = sinB;
}
