module Layout {
    // fēnix 7S Pro MIP: 260x260
    const W = 260;
    const H = 260;

    const CX = 130;
    const CY = 130;

    // Banda central ~23%
    const MID_H = 60;
    const MID_Y0 = (H - MID_H) / 2; // 100
    const MID_Y1 = MID_Y0 + MID_H;  // 160

    const SEP_THICK = 2;

    // Hitbox tap batería (ajustable)
    const BATT_HIT_X0 = 30;
    const BATT_HIT_X1 = 230;
    const BATT_HIT_Y0 = 185;
    const BATT_HIT_Y1 = 250;
}