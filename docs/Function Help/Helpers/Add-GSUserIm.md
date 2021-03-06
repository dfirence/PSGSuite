# Add-GSUserIm

## SYNOPSIS
Builds an IM object to use when creating or updating a User

## SYNTAX

### Fields
```
Add-GSUserIm [-CustomProtocol <String>] [-CustomType <String>] [-Im <String>] [-Primary] [-Protocol <String>]
 [-Type <String>] [<CommonParameters>]
```

### InputObject
```
Add-GSUserIm [-InputObject <UserIm[]>] [<CommonParameters>]
```

## DESCRIPTION
Builds an IM object to use when creating or updating a User

## EXAMPLES

### EXAMPLE 1
```
$address = Add-GSUserAddress -Country USA -Locality Dallas -PostalCode 75000 Region TX -StreetAddress '123 South St' -Type Work -Primary
```

$phone = Add-GSUserPhone -Type Work -Value "(800) 873-0923" -Primary

$extId = Add-GSUserExternalId -Type Login_Id -Value jsmith2

$email = Add-GSUserEmail -Type work -Address jsmith@contoso.com

$im = Add-GSUserIm -Type work -Protocol custom_protocol -CustomProtocol spark -Im jsmithertons100

New-GSUser -PrimaryEmail john.smith@domain.com -GivenName John -FamilyName Smith -Password (ConvertTo-SecureString -String 'Password123' -AsPlainText -Force) -ChangePasswordAtNextLogin -OrgUnitPath "/Users/New Hires" -IncludeInGlobalAddressList -Addresses $address -Phones $phone -ExternalIds $extId -Emails $email -Ims $im

Creates a user named John Smith and adds their work address, work phone, IM, login_id and alternate non gsuite work email to the user object.

## PARAMETERS

### -CustomProtocol
If the protocol value is custom_protocol, this property holds the custom protocol's string.

```yaml
Type: String
Parameter Sets: Fields
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CustomType
If the value of type is custom, this property contains the custom type.

```yaml
Type: String
Parameter Sets: Fields
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Im
The user's IM network ID.

```yaml
Type: String
Parameter Sets: Fields
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Used for pipeline input of an existing IM object to strip the extra attributes and prevent errors

```yaml
Type: UserIm[]
Parameter Sets: InputObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Primary
If this is the user's primary IM.
Only one entry in the IM list can have a value of true.

```yaml
Type: SwitchParameter
Parameter Sets: Fields
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Protocol
An IM protocol identifies the IM network.
The value can be a custom network or the standard network.

Acceptable values are:
* "aim": AOL Instant Messenger protocol
* "custom_protocol": A custom IM network protocol
* "gtalk": Google Talk protocol
* "icq": ICQ protocol
* "jabber": Jabber protocol
* "msn": MSN Messenger protocol
* "net_meeting": Net Meeting protocol
* "qq": QQ protocol
* "skype": Skype protocol
* "yahoo": Yahoo Messenger protocol


"aim","custom_protocol","gtalk","icq","jabber","msn","net_meeting","qq","skype","yahoo"

```yaml
Type: String
Parameter Sets: Fields
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
The type of the IM account.

Acceptable values are:
* "custom"
* "home"
* "other"
* "work"

```yaml
Type: String
Parameter Sets: Fields
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Google.Apis.Admin.Directory.directory_v1.Data.UserIm
## NOTES

## RELATED LINKS
