import 'package:flutter/material.dart';
import 'package:datamate_g3_ui/datamate_g3_ui.dart';
import '../common/showcase_card.dart';
import '../common/showcase_header.dart';
import '../common/showcase_scaffold.dart';

/// Interactive showcase for Datamate G3 Dropdown components mapped to `docs/guidelines/dropdowns.md`.
class DropdownsView extends StatefulWidget {
  const DropdownsView({
    super.key,
    this.targetItem,
  });

  final String? targetItem;

  static const String componentId = 'dropdowns';

  @override
  State<DropdownsView> createState() => _DropdownsViewState();
}

class _DropdownsViewState extends State<DropdownsView> {
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

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      componentId: DropdownsView.componentId,
      targetItem: widget.targetItem,
      builder: (context, keyFor, isHighlighted) => [
        const ShowcaseHeader(
          title: 'Dropdowns & Selection Fields',
          docPath: 'docs/guidelines/dropdowns.md',
          summary:
              'Selection fields conforming strictly to Datamate G3 tokens: 40px fixed height, #ECEFF2 fill, 6px radius, left-aligned label with 8px gap. Supports standard pickers, instant local search overlays, and debounced asynchronous API lazy-loading.',
        ),

        // 1. Standard Dropdown with Label
        ShowcaseCard(
          key: keyFor('standard'),
          componentId: DropdownsView.componentId,
          itemId: 'standard',
          isHighlighted: isHighlighted('standard'),
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
        ShowcaseCard(
          key: keyFor('searchable'),
          componentId: DropdownsView.componentId,
          itemId: 'searchable',
          isHighlighted: isHighlighted('searchable'),
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
        ShowcaseCard(
          key: keyFor('async'),
          componentId: DropdownsView.componentId,
          itemId: 'async',
          isHighlighted: isHighlighted('async'),
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
        ShowcaseCard(
          key: keyFor('icons'),
          componentId: DropdownsView.componentId,
          itemId: 'icons',
          isHighlighted: isHighlighted('icons'),
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
        ShowcaseCard(
          key: keyFor('inline'),
          componentId: DropdownsView.componentId,
          itemId: 'inline',
          isHighlighted: isHighlighted('inline'),
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
        ShowcaseCard(
          key: keyFor('disabled'),
          componentId: DropdownsView.componentId,
          itemId: 'disabled',
          isHighlighted: isHighlighted('disabled'),
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
      ],
    );
  }
}
