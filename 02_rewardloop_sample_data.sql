-- Sample data for RewardLoop

INSERT INTO Customer VALUES
(1, 'Aarav Mehta', 'aarav.mehta@example.com', '9876501001', '2026-01-10'),
(2, 'Diya Shah', 'diya.shah@example.com', '9876501002', '2026-02-05'),
(3, 'Kabir Rao', 'kabir.rao@example.com', '9876501003', '2026-03-12'),
(4, 'Mira Iyer', 'mira.iyer@example.com', '9876501004', '2026-04-20');

INSERT INTO Store VALUES
(1, 'RewardLoop Central', '12 MG Road', 'Mumbai'),
(2, 'RewardLoop Seaside', '44 Palm Avenue', 'Navi Mumbai'),
(3, 'RewardLoop Market', '8 Station Road', 'Thane');

INSERT INTO Purchase VALUES
(101, 1, 1, '2026-08-01 10:15:00', 1200.00),
(102, 1, 2, '2026-08-14 18:30:00', 800.00),
(103, 2, 1, '2026-08-03 13:05:00', 650.00),
(104, 2, 3, '2026-08-21 16:45:00', 1400.00),
(105, 3, 2, '2026-08-11 11:20:00', 500.00),
(106, 4, 3, '2026-08-25 19:10:00', 2200.00);

INSERT INTO Reward VALUES
(1, 'Coffee Voucher', 'One regular hot or iced coffee', 100, 'Bronze', TRUE),
(2, 'Shopping Discount', 'INR 250 off an eligible purchase', 250, 'Silver', TRUE),
(3, 'Gift Hamper', 'Curated retail gift hamper', 500, 'Gold', TRUE),
(4, 'Premium Member Pack', 'Premium seasonal gift pack', 900, 'Platinum', TRUE);

-- Sample earning rate: 1 point per INR 10 spent.
INSERT INTO LoyaltyPoint VALUES
(1, 1, 101, NULL, 120, '2026-08-01 10:16:00', 'Points earned from purchase'),
(2, 1, 102, NULL, 80, '2026-08-14 18:31:00', 'Points earned from purchase'),
(3, 2, 103, NULL, 65, '2026-08-03 13:06:00', 'Points earned from purchase'),
(4, 2, 104, NULL, 140, '2026-08-21 16:46:00', 'Points earned from purchase'),
(5, 3, 105, NULL, 50, '2026-08-11 11:21:00', 'Points earned from purchase'),
(6, 4, 106, NULL, 220, '2026-08-25 19:11:00', 'Points earned from purchase'),
(7, 1, NULL, 1, -100, '2026-08-16 12:00:00', 'Redeemed Coffee Voucher'),
(8, 2, NULL, 1, -100, '2026-08-22 12:00:00', 'Redeemed Coffee Voucher');
