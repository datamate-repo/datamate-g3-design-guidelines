import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:datamate_g3_ui/datamate_g3_ui.dart';

/// Interactive Component Explorer rendering live UI showcases directly
/// mapped to corresponding markdown guidelines in `docs/guidelines/`.
class ComponentExplorer extends StatefulWidget {
  const ComponentExplorer({
    super.key,
    required this.componentId,
    this.targetItem,
  });

  final String componentId;
  final String? targetItem;

  @override
  State<ComponentExplorer> createState() => _ComponentExplorerState();
}

class _ComponentExplorerState extends State<ComponentExplorer> {
  final Map<String, GlobalKey> _cardKeys = {};
  String? _highlightedItem;

  // Dropdown state
  String? _selectedRole = 'Administrator';
  String? _selectedCategory = 'development';
  String? _selectedInlineStatus = 'Active';

  // Searchable dropdown state (Local filtering)
  String? _selectedCountry = 'United States';
  static const _sampleCountries = [
    'Australia', 'Austria', 'Belgium', 'Brazil', 'Canada', 'Denmark',
    'Finland', 'France', 'Germany', 'India', 'Ireland', 'Italy',
    'Japan', 'Netherlands', 'New Zealand', 'Norway', 'Singapore',
    'South Korea', 'Spain', 'Sweden', 'Switzerland', 'United Kingdom',
    'United States',
  ];

  // Async dropdown state (Remote/API simulation)
  String? _selectedCustomer = 'Acme Global Corp';
  List<String> _asyncCustomerList = [];
  bool _isAsyncLoading = false;

  @override
  void initState() {
    super.initState();
    _asyncCustomerList = [
      'Acme Global Corp',
      'Apex Industrial Systems',
      'Bluebird Logistics',
      'Cascade Health Technologies',
      'Cloudflare Infrastructure',
      'Cyberdyne Robotics',
    ];

    if (widget.targetItem != null) {
      _scheduleScrollToTarget(widget.targetItem!);
    }
  }

  @override
  void didUpdateWidget(covariant ComponentExplorer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.targetItem != oldWidget.targetItem && widget.targetItem != null) {
      _scheduleScrollToTarget(widget.targetItem!);
    }
  }

  void _scheduleScrollToTarget(String itemId) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final key = _cardKeys[itemId];
      if (key?.currentContext != null) {
        Scrollable.ensureVisible(
          key!.currentContext!,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          alignment: 0.05,
        );
        setState(() => _highlightedItem = itemId);
        Future.delayed(const Duration(milliseconds: 2000), () {
          if (mounted && _highlightedItem == itemId) {
            setState(() => _highlightedItem = null);
          }
        });
      }
    });
  }

  GlobalKey _keyFor(String itemId) {
    return _cardKeys.putIfAbsent(itemId, () => GlobalKey());
  }

  void _simulateRemoteSearch(String query) {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() => _isAsyncLoading = true);
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!mounted) return;
        const allCustomers = [
          'Acme Global Corp',
          'Apex Industrial Systems',
          'Bluebird Logistics',
          'Cascade Health Technologies',
          'Cloudflare Infrastructure',
          'Cyberdyne Robotics',
          'Delta Aviation Partners',
          'Horizon Media Group',
          'Initech Software Labs',
          'Lexington Financial Services',
          'Omni Consumer Products',
          'Pied Piper Cloud Storage',
          'Stark Industries Group',
          'Soylent Food Technologies',
          'Umbrella Pharmaceuticals',
          'Wayne Enterprises Security',
          'Zeta Telecommunications',
        ];
        final filtered = query.trim().isEmpty
            ? allCustomers
            : allCustomers.where((c) => c.toLowerCase().contains(query.toLowerCase())).toList();
        if (!mounted) return;
        setState(() {
          _asyncCustomerList = filtered;
          _isAsyncLoading = false;
        });
      });
    });
  }

  // Button state demo
  bool _isSaving = false;
  String? _lastActionMessage;

  void _triggerSimulatedSave() {
    setState(() {
      _isSaving = true;
      _lastActionMessage = 'Saving changes in background...';
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isSaving = false;
          _lastActionMessage = 'Changes saved successfully!';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.datamateSpacing;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: spacing.lg,
        vertical: spacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildContentForComponent(context),
      ),
    );
  }

  List<Widget> _buildContentForComponent(BuildContext context) {
    switch (widget.componentId) {
      case 'text-fields':
        return _buildTextFieldsShowcase(context);
      case 'buttons':
        return _buildButtonsShowcase(context);
      case 'dropdowns':
        return _buildDropdownsShowcase(context);
      default:
        return [
          const Text('Select a component from the sidebar navigation.')
        ];
    }
  }

  // ───────────────────────────────────────────────────────────
  // SHOWCASE CONTAINERS & HEADERS
  // ───────────────────────────────────────────────────────────

  Widget _buildDocHeader(
    BuildContext context, {
    required String title,
    required String docPath,
    required String summary,
  }) {
    final colors = context.datamateColors;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: colors.primaryDarkBlue,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: colors.borderLight),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.description_outlined,
                        size: 13, color: colors.textMuted),
                    const SizedBox(width: 4),
                    Text(
                      docPath,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: colors.textMuted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            summary,
            style: TextStyle(
              fontSize: 13.5,
              color: colors.textMuted,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String itemId,
    required String title,
    required String docAnchor,
    required String ruleDescription,
    required Widget child,
  }) {
    final colors = context.datamateColors;
    final isHighlighted = _highlightedItem == itemId;

    return Container(
      key: _keyFor(itemId),
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isHighlighted ? colors.primaryDarkBlue : colors.borderLight,
          width: isHighlighted ? 2.0 : 1.0,
        ),
        boxShadow: isHighlighted
            ? [
                BoxShadow(
                  color: colors.primaryDarkBlue.withValues(alpha: 0.18),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: colors.primaryDarkBlue,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Markdown Spec reference badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: colors.borderLight),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.menu_book_outlined, size: 12, color: colors.textMuted),
                    const SizedBox(width: 4),
                    Text(
                      docAnchor,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: colors.textMuted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              // Copy Deep Link Icon Button
              IconButton(
                icon: const Icon(Icons.link_rounded, size: 17),
                tooltip: 'Copy Deep Link (/#/${widget.componentId}?item=$itemId)',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
                splashRadius: 16,
                color: colors.textMuted,
                hoverColor: colors.primaryDarkBlue.withValues(alpha: 0.08),
                onPressed: () {
                  final host = Uri.base.host.isNotEmpty ? Uri.base.host : 'localhost';
                  final port = Uri.base.hasPort ? ':${Uri.base.port}' : '';
                  final deepLink = 'http://$host$port/#/${widget.componentId}?item=$itemId';
                  Clipboard.setData(ClipboardData(text: deepLink));
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 16),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Deep link copied: /#/${widget.componentId}?item=$itemId',
                              style: const TextStyle(fontSize: 12.5),
                            ),
                          ),
                        ],
                      ),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      width: 440,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            ruleDescription,
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────────────
  // 1. TEXT FIELDS SHOWCASE (docs/guidelines/text-fields.md)
  // ───────────────────────────────────────────────────────────

  List<Widget> _buildTextFieldsShowcase(BuildContext context) {
    return [
      _buildDocHeader(
        context,
        title: 'Text Fields',
        docPath: 'docs/guidelines/text-fields.md',
        summary:
            'All text inputs maintain a 40px fixed height, #ECEFF2 subtle fill, 12px interior padding, and 6px border radius. Labels sit horizontally on the left with an 8px gap.',
      ),

      // 1. Standard Input
      _buildCard(
        context,
        itemId: 'standard',
        title: '1. Standard Input (Editable)',
        docAnchor: 'text-fields.md#1-standard-input',
        ruleDescription:
            'Default text field with left-aligned label separated by an 8px gap. Text style: Poppins 13.5px Medium in #1E293B.',
        child: const SizedBox(
          width: 440,
          child: DatamateTextField(
            label: 'Full Name:',
            placeholder: 'e.g. Alex Morgan',
            labelWidth: 100,
          ),
        ),
      ),

      // 2. Numeric / Currency Input
      _buildCard(
        context,
        itemId: 'numeric',
        title: '2. Numeric / Currency Input',
        docAnchor: 'text-fields.md#2-numeric--currency-input',
        ruleDescription:
            'Right-aligned text with 0.00 default numerical placeholder. Preserves 40px height and 6px corner radius.',
        child: const SizedBox(
          width: 300,
          child: DatamateTextField(
            label: 'Price (\$):',
            initialValue: '1,250.00',
            textAlign: TextAlign.right,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            labelWidth: 80,
          ),
        ),
      ),

      // 3. Input with Prefix & Suffix Icons
      _buildCard(
        context,
        itemId: 'icons',
        title: '3. Inputs with Prefix & Suffix Icons',
        docAnchor: 'text-fields.md#3-prefix--suffix-icon-inputs',
        ruleDescription:
            'Interior icons for email addresses, calendar date triggers, or clear buttons. Preserves strict 40px fixed height in all states.',
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: const [
            SizedBox(
              width: 360,
              child: DatamateTextField(
                label: 'Email:',
                placeholder: 'alex.morgan@company.com',
                prefixIcon: Icon(Icons.mail_outline_rounded, size: 18, color: Color(0xFF64748B)),
                labelWidth: 80,
              ),
            ),
            SizedBox(
              width: 320,
              child: DatamateTextField(
                label: 'Due Date:',
                initialValue: '26-Oct-2026',
                suffixIcon: Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF64748B)),
                labelWidth: 80,
              ),
            ),
          ],
        ),
      ),

      // 4. Disabled State
      _buildCard(
        context,
        itemId: 'disabled',
        title: '4. Disabled / Read-Only State',
        docAnchor: 'text-fields.md#4-read-only--disabled-input',
        ruleDescription:
            'Disabled inputs apply muted text (#64748B) and 50% opacity borders to indicate non-interactive status.',
        child: const SizedBox(
          width: 440,
          child: DatamateTextField(
            label: 'System ID:',
            initialValue: 'SYS-USR-09412 (Read-Only)',
            enabled: false,
            labelWidth: 100,
          ),
        ),
      ),

      // 5. Side-by-Side Rhythm (16px gap)
      _buildCard(
        context,
        itemId: 'spacing',
        title: '5. Side-by-Side Form Spacing (16px Baseline Grid)',
        docAnchor: 'text-fields.md#spacing-between-multiple-fields',
        ruleDescription:
            'Adjacent form fields maintain exactly 16px horizontal spacing between outer boundaries.',
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: const [
            SizedBox(
              width: 300,
              child: DatamateTextField(
                label: 'First Name:',
                initialValue: 'Eleanor',
                labelWidth: 90,
              ),
            ),
            SizedBox(
              width: 300,
              child: DatamateTextField(
                label: 'Last Name:',
                initialValue: 'Vance',
                labelWidth: 90,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  // ───────────────────────────────────────────────────────────
  // 2. BUTTONS & ACTIONS SHOWCASE (docs/guidelines/buttons.md)
  // ───────────────────────────────────────────────────────────

  List<Widget> _buildButtonsShowcase(BuildContext context) {
    final colors = context.datamateColors;

    return [
      _buildDocHeader(
        context,
        title: 'Buttons & Actions',
        docPath: 'docs/guidelines/buttons.md',
        summary:
            'Standard action controls: Primary (#20389B for main progression), Exit (#D32F2F for discard/close), and Secondary (Outlined). Row-level actions use simple icon buttons in green (add), orange (clear), and red (delete).',
      ),

      // 1. Primary Button
      _buildCard(
        context,
        itemId: 'primary',
        title: '1. Primary Button (Save / Submit / Confirm)',
        docAnchor: 'buttons.md#1-primary-button-save--submit--confirm',
        ruleDescription:
            'Height: 40px, Background: #20389B, Font: Poppins 13.5px Semi-Bold, Radius: 6px. Typically positioned on the far right of action bars.',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                DatamatePrimaryButton(
                  label: 'Save Changes',
                  icon: Icons.check_circle_outline_rounded,
                  isLoading: _isSaving,
                  onPressed: _triggerSimulatedSave,
                ),
                DatamatePrimaryButton(
                  label: 'Create Item',
                  icon: Icons.add,
                  onPressed: () {
                    setState(() => _lastActionMessage = 'Action: Create Item triggered');
                  },
                ),
                const DatamatePrimaryButton(
                  label: 'Disabled Action',
                  onPressed: null,
                ),
              ],
            ),
            if (_lastActionMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                'Feedback: $_lastActionMessage',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: colors.primaryDarkBlue,
                ),
              ),
            ],
          ],
        ),
      ),

      // 2. Exit / Discard Button
      _buildCard(
        context,
        itemId: 'exit',
        title: '2. Exit / Discard Button',
        docAnchor: 'buttons.md#2-exit-button-close--discard',
        ruleDescription:
            'Height: 36px, Background: Semantic Red (#D32F2F), Font: Poppins 13px Semi-Bold. Anchored at the far right of top navigation bars.',
        child: Wrap(
          spacing: 16,
          children: [
            DatamateExitButton(
              label: 'Close',
              onPressed: () {
                setState(() => _lastActionMessage = 'Action: Close triggered');
              },
            ),
            DatamateExitButton(
              label: 'Discard Changes',
              onPressed: () {
                setState(() => _lastActionMessage = 'Action: Discard Changes triggered');
              },
            ),
          ],
        ),
      ),

      // 3. Secondary Buttons
      _buildCard(
        context,
        itemId: 'secondary',
        title: '3. Secondary Action Buttons (Outlined)',
        docAnchor: 'buttons.md#3-secondary-button-outlined',
        ruleDescription:
            'Height: 40px, Transparent background with 1px #DCE1E7 border, #20389B text. Positioned on the left of action bars for utility actions.',
        child: Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            DatamateSecondaryButton(
              label: 'View All',
              icon: Icons.view_list_rounded,
              onPressed: () {
                setState(() => _lastActionMessage = 'Secondary action: View All');
              },
            ),
            DatamateSecondaryButton(
              label: 'Export CSV',
              icon: Icons.file_download_outlined,
              onPressed: () {
                setState(() => _lastActionMessage = 'Secondary action: Export CSV');
              },
            ),
            DatamateSecondaryButton(
              label: 'Print Report',
              icon: Icons.print_outlined,
              onPressed: () {
                setState(() => _lastActionMessage = 'Secondary action: Print Report');
              },
            ),
          ],
        ),
      ),

      // 4. Row Action Buttons
      _buildCard(
        context,
        itemId: 'row-actions',
        title: '4. Row Action Buttons (Simple Icon Buttons)',
        docAnchor: 'buttons.md#4-row-action-buttons-grid-inline',
        ruleDescription:
            'Clean icon buttons with no container tiles or borders. Green (#2E7D32) = Add, Orange (#ED6C02) = Clear, Red (#D32F2F) = Delete. 8px gaps between buttons.',
        child: Row(
          children: [
            DatamateRowActionButton(
              type: DatamateRowActionType.add,
              onPressed: () {
                setState(() => _lastActionMessage = 'Row action: Add Row clicked');
              },
            ),
            const SizedBox(width: 8),
            DatamateRowActionButton(
              type: DatamateRowActionType.clear,
              onPressed: () {
                setState(() => _lastActionMessage = 'Row action: Clear Row clicked');
              },
            ),
            const SizedBox(width: 8),
            DatamateRowActionButton(
              type: DatamateRowActionType.delete,
              onPressed: () {
                setState(() => _lastActionMessage = 'Row action: Delete Row clicked');
              },
            ),
            const SizedBox(width: 20),
            Text(
              '← Simple icon buttons with semantic colors and 8px gaps',
              style: TextStyle(fontSize: 12, color: colors.textMuted),
            ),
          ],
        ),
      ),
    ];
  }

  // ───────────────────────────────────────────────────────────
  // 3. DROPDOWNS SHOWCASE (docs/guidelines/dropdowns.md)
  // ───────────────────────────────────────────────────────────

  List<Widget> _buildDropdownsShowcase(BuildContext context) {
    return [
      _buildDocHeader(
        context,
        title: 'Dropdowns & Selection Fields',
        docPath: 'docs/guidelines/dropdowns.md',
        summary:
            'Selection fields conforming strictly to Datamate G3 tokens: 40px fixed height, #ECEFF2 fill, 6px radius, left-aligned label with 8px gap. Supports standard pickers, instant local search overlays, and debounced asynchronous API lazy-loading.',
      ),

      // 1. Standard Dropdown with Label
      _buildCard(
        context,
        itemId: 'standard',
        title: '1. Standard Dropdown with Left-Aligned Label',
        docAnchor: 'dropdowns.md#1-standard-dropdown-datamatedropdown',
        ruleDescription:
            '40px height, 6px radius, 12px interior padding. Label sits on the left with an 8px gap.',
        child: SizedBox(
          width: 440,
          child: DatamateDropdown<String>(
            label: 'User Role:',
            labelWidth: 110,
            value: _selectedRole,
            items: const [
              DatamateDropdownItem(value: 'Administrator', label: 'Administrator'),
              DatamateDropdownItem(value: 'Editor', label: 'Editor'),
              DatamateDropdownItem(value: 'Contributor', label: 'Contributor'),
              DatamateDropdownItem(value: 'Viewer', label: 'Viewer'),
            ],
            onChanged: (val) {
              setState(() => _selectedRole = val);
            },
          ),
        ),
      ),

      // 2. Searchable Dropdown (Local Search Overlay)
      _buildCard(
        context,
        itemId: 'searchable',
        title: '2. Searchable Dropdown (Anchored Overlay & Local Filter)',
        docAnchor: 'dropdowns.md#2-searchable-dropdown-datamatesearchabledropdown',
        ruleDescription:
            'Anchored floating overlay with bounds-checking. Alphanumeric keypress on focused trigger auto-opens search. Arrow keys navigate, Enter selects, Esc dismisses. Includes clearable (✕) trigger icon.',
        child: SizedBox(
          width: 440,
          child: DatamateSearchableDropdown<String>(
            label: 'Country / Region:',
            labelWidth: 110,
            hint: 'Select country...',
            clearable: true,
            selectedItem: _selectedCountry,
            items: _sampleCountries,
            searchStringBuilder: (c) => c,
            titleBuilder: (c) => c,
            itemBuilder: (c) => Text(c, style: const TextStyle(fontSize: 13.5)),
            onChanged: (val) {
              setState(() => _selectedCountry = val);
            },
          ),
        ),
      ),

      // 3. Asynchronous / API Searchable Dropdown (Lazy Loading)
      _buildCard(
        context,
        itemId: 'async',
        title: '3. Asynchronous / API Dropdown (Debounced Lazy-Loading)',
        docAnchor: 'dropdowns.md#3-asynchronous-searchable-dropdown-datamateasyncsearchabledropdown',
        ruleDescription:
            'Debounced remote API queries (500ms) with reactive loading spinner, empty states, and anchored overlay positioning.',
        child: SizedBox(
          width: 440,
          child: DatamateAsyncSearchableDropdown<String>(
            label: 'Customer Account:',
            labelWidth: 110,
            hint: 'Search customer...',
            clearable: true,
            selectedItem: _selectedCustomer,
            items: _asyncCustomerList,
            isLoading: _isAsyncLoading,
            onSearch: _simulateRemoteSearch,
            titleBuilder: (c) => c,
            itemBuilder: (c) => Row(
              children: [
                const Icon(Icons.business_outlined, size: 16, color: Color(0xFF64748B)),
                const SizedBox(width: 8),
                Text(c, style: const TextStyle(fontSize: 13.5)),
              ],
            ),
            onChanged: (val) {
              setState(() => _selectedCustomer = val);
            },
          ),
        ),
      ),

      // 4. Dropdown with Leading Option Icons
      _buildCard(
        context,
        itemId: 'icons',
        title: '4. Dropdown with Leading Option Icons',
        docAnchor: 'dropdowns.md#dropdown-types',
        ruleDescription:
            'Dropdown options can include a leading 16px icon for immediate visual category identification.',
        child: SizedBox(
          width: 440,
          child: DatamateDropdown<String>(
            label: 'Category:',
            labelWidth: 110,
            value: _selectedCategory,
            items: const [
              DatamateDropdownItem(value: 'development', label: 'Engineering & Development', icon: Icons.code_rounded),
              DatamateDropdownItem(value: 'design', label: 'Product Design & UX', icon: Icons.palette_outlined),
              DatamateDropdownItem(value: 'marketing', label: 'Growth & Marketing', icon: Icons.campaign_outlined),
              DatamateDropdownItem(value: 'support', label: 'Customer Support', icon: Icons.support_agent_rounded),
            ],
            onChanged: (val) {
              setState(() => _selectedCategory = val);
            },
          ),
        ),
      ),

      // 5. Inline Dropdown (No Label)
      _buildCard(
        context,
        itemId: 'inline',
        title: '5. Inline Dropdown (Grid & Table Cell Usage)',
        docAnchor: 'dropdowns.md#core-principle',
        ruleDescription:
            'When placed inside table cells or inline toolbars, the label is omitted and the dropdown fills the container.',
        child: SizedBox(
          width: 220,
          child: DatamateDropdown<String>(
            value: _selectedInlineStatus,
            items: const [
              DatamateDropdownItem(value: 'Active', label: 'Active Status'),
              DatamateDropdownItem(value: 'Pending', label: 'Pending Approval'),
              DatamateDropdownItem(value: 'Suspended', label: 'Suspended Account'),
              DatamateDropdownItem(value: 'Archived', label: 'Archived Record'),
            ],
            onChanged: (val) {
              setState(() => _selectedInlineStatus = val);
            },
          ),
        ),
      ),

      // 6. Disabled Dropdown
      _buildCard(
        context,
        itemId: 'disabled',
        title: '6. Disabled State',
        docAnchor: 'dropdowns.md#focus--active-states',
        ruleDescription:
            'Non-interactive dropdown with 50% opacity border and disabled chevron icon.',
        child: const SizedBox(
          width: 440,
          child: DatamateDropdown<String>(
            label: 'Account Tier:',
            labelWidth: 110,
            value: 'Enterprise',
            enabled: false,
            items: [
              DatamateDropdownItem(value: 'Enterprise', label: 'Enterprise Plan (Locked)'),
            ],
          ),
        ),
      ),
    ];
  }
}
